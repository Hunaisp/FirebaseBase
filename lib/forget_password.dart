import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example1/toast_message.dart';
import 'package:flutter/material.dart';

class FotgetPassword extends StatefulWidget {
  const FotgetPassword({Key? key}) : super(key: key);

  @override
  State<FotgetPassword> createState() => _FotgetPasswordState();
}

TextEditingController email = TextEditingController();
final auth=FirebaseAuth.instance;
class _FotgetPasswordState extends State<FotgetPassword> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            width: mwidth * 0.94,
            height: mheight * 0.075,
            color: Colors.grey,
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
          ),
          SizedBox(
            height: mheight * 0.03,
          ),
          TextButton(
              onPressed: () {
                auth.sendPasswordResetEmail(email: email.text).then((value) {
                  ToastMessage().toastmessage(message: 'password changed successfully');
                }).onError((error, stackTrace){
                  ToastMessage().toastmessage(message: error.toString());
                });
              },
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}
