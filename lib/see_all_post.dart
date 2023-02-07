import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_example1/toast_message.dart';
import 'package:flutter/material.dart';

class Post_screen extends StatefulWidget {
  const Post_screen({Key? key}) : super(key: key);

  @override
  State<Post_screen> createState() => _Post_screenState();
}

final ref = FirebaseDatabase.instance.ref('post');
TextEditingController search = TextEditingController();

class _Post_screenState extends State<Post_screen> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: mwidth * 0.65,
            height: mheight * 0.05,
            color: Colors.white,
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: search,
              decoration: InputDecoration(hintText: 'enter a keyword'),
            ),
          ),
          backgroundColor: Colors.purple,
        ),
        body: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            final title = snapshot.child('title').value.toString();
            if (title.toLowerCase().contains(search.text.toLowerCase())) {
              return ListTile(
                title: Text(snapshot.child('title').value.toString()),
                leading: TextButton(
                    onPressed: () {
                      dialogBox(id:snapshot.child('id').value.toString(), title: snapshot.child('title').value.toString());
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    )),
                trailing: TextButton(
                    onPressed: () {
                      ref.child(snapshot.child('id').value.toString()).remove();
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    )),
              );
            }
            if (search.text.isEmpty) {
              return ListTile(
                title: Text(snapshot.child('title').value.toString()),
                leading: TextButton(
                    onPressed: () {
                      dialogBox(id:snapshot.child('id').value.toString(), title: snapshot.child('title').value.toString());
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    )),
                trailing: TextButton(
                    onPressed: () {
                      ref.child(snapshot.child('id').value.toString()).remove();
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    )),
              );
            } else {
              return Container();
            }
          },
        ));
  }

  Future<void> dialogBox({required String id, required String title}) async {
    final newValue = TextEditingController(text: title.toString());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Update',
              style:
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
            ),content: TextFormField(controller: newValue,),
            actions: [
              TextButton(
                  onPressed: () {
                    ref.child(id).update({
                      'title':newValue.text.toLowerCase(),
                    }).then((value) {
                      ToastMessage().toastmessage(message: 'Updated Successfully');
                      Navigator.of(context).pop();
                    }).onError((error, stackTrace) {
                      ToastMessage().toastmessage(message: error.toString());
                    });
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w500),
                  )),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w500),
                  )),
            ],
          );
        });
  }
}
