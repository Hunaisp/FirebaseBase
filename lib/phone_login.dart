import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example1/phone_number_verification_screen.dart';
import 'package:firebase_example1/toast_message.dart';
import 'package:flutter/material.dart';

class Phone_login extends StatefulWidget {
  const Phone_login({Key? key}) : super(key: key);

  @override
  State<Phone_login> createState() => _Phone_loginState();
}

TextEditingController phone = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _Phone_loginState extends State<Phone_login> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery
        .of(context)
        .size
        .width;
    var mheight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(appBar: AppBar(backgroundColor: Colors.purple,), body:

    Column(children: [
      SizedBox(height: mheight * 0.03,),
      Container(
        width: mwidth * 0.94,
        height: mheight * 0.05,
        color: Colors.grey,
        child: TextFormField(
          controller: phone,
          decoration: InputDecoration(hintText: 'phone number'),
        ),
      ), SizedBox(height: mheight * 0.02,), GestureDetector(onTap: () {
        auth.verifyPhoneNumber(phoneNumber: phone.text,verificationCompleted: (_){},
            verificationFailed: (e){
              ToastMessage().toastmessage(message: e.toString());
            },
            codeSent: (String verificationId,int? token){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>Verify_screen(verificationId: verificationId,)));

            },
            codeAutoRetrievalTimeout: (e){
              ToastMessage().toastmessage(message: e.toString());
            });
      },
        child: Text(
          'Click On Verify',
          style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ),
      ),
    ],)


      ,);
  }
}
