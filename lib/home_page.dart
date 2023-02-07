import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example1/see_all_post.dart';
import 'package:firebase_example1/see_all_post_in_firestore.dart';
import 'package:firebase_example1/toast_message.dart';
import 'package:firebase_example1/upload_image.dart';
import 'package:flutter/material.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

TextEditingController post = TextEditingController();
final firestore = FirebaseFirestore.instance.collection('Post');

class _Home_screenState extends State<Home_screen> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Home Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: mheight * 0.02,
          ),
          Container(
            width: mwidth * 0.94,
            height: mheight * 0.075,
            color: Colors.grey,
            child: TextFormField(
              controller: post,
              decoration: InputDecoration(hintText: 'what is in your mind?'),
            ),
          ),
          SizedBox(
            height: mheight * 0.035,
          ),
          TextButton(
              onPressed: () {
                final id = DateTime.now().microsecondsSinceEpoch.toString();
                firestore
                    .doc(id)
                    .set({'title': post.text, 'id': id})
                    .then((value) =>
                        {ToastMessage().toastmessage(message: 'Post Added')})
                    .onError((error, stackTrace) =>
                        ToastMessage().toastmessage(message: error.toString()));
              },
              child: Container(
                width: mwidth * 0.185,
                height: mheight * 0.05,
                color: Colors.purple,
                child: Center(
                  child: Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              )),
          SizedBox(
            height: mheight * 0.06,
          ),
          TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext a) => Post_screen_firestore())),
              child: Text(
                'See All Post',
                style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.w500),
              )),
          SizedBox(
            height: mheight * 0.03,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>UploadImage()));
              },
              child: Text(
                'Upload Your Image',
                style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}
