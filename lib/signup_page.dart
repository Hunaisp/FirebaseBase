import 'package:firebase_example1/phone_login.dart';
import 'package:firebase_example1/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './toast_message.dart';
import 'login_page.dart';

class Signup_page extends StatefulWidget {
  const Signup_page({Key? key}) : super(key: key);

  @override
  State<Signup_page> createState() => _Signup_pageState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _Signup_pageState extends State<Signup_page> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'FireBaseDemo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: mheight * 0.035,
          ),
          Container(
            width: mwidth * 0.94,
            height: mheight * 0.05,
            color: Colors.grey,
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(hintText: 'Email'),
            ),
          ),
          SizedBox(
            height: mheight * 0.02,
          ),
          Container(
            width: mwidth * 0.94,
            height: mheight * 0.05,
            color: Colors.grey,
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(hintText: 'password'),
            ),
          ),
          SizedBox(
            height: mheight * 0.05,
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  auth
                      .createUserWithEmailAndPassword(
                          email: email.text, password: password.text)
                      .then((value) => {
                        ToastMessage().toastmessage(message: 'Successfully registerd')
                      })
                      .onError((error, stackTrace) => ToastMessage()
                          .toastmessage(message: error.toString()));
                },
                child: Container(
                  width: mwidth * 0.25,
                  height: mheight * 0.06,
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      'Signup',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: mheight * 0.02,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext a) => Login_page())),
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ),SizedBox(height: mheight*0.02,),GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext a) => Phone_login())),
            child: Text(
              'Register with phone',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
