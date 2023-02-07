import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Post_screen extends StatefulWidget {
  const Post_screen({Key? key}) : super(key: key);

  @override
  State<Post_screen> createState() => _Post_screenState();
}

final ref = FirebaseDatabase.instance.ref('post');

class _Post_screenState extends State<Post_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
        ),
        body: StreamBuilder(
          stream: ref.onValue,
          builder:
              (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Oops Something went wrong');
            }
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map =
                  snapshot.data!.snapshot.value as dynamic;
              List<dynamic> list = [];
              list=map.values.toList();
              return ListView.builder(itemCount: list.length,itemBuilder: (BuildContext context,int index){
                return ListTile(title: Text(list[index]['title'].toString()),subtitle: Text(list[index]['id']),);
              });
            }
            else{
              return SizedBox();
            }
          },
        ));
  }
}
