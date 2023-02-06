import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example1/home_page.dart';
import 'package:firebase_example1/toast_message.dart';
import 'package:flutter/material.dart';

class Verify_screen extends StatefulWidget {
  final verificationId;

  const Verify_screen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<Verify_screen> createState() => _Verify_screenState();
}

TextEditingController verificationcode = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _Verify_screenState extends State<Verify_screen> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Container(
            width: mwidth * 0.94,
            height: mheight * 0.05,
            color: Colors.grey,
            child: TextFormField(
              controller: verificationcode,
              decoration: InputDecoration(hintText: 'verification code'),
            ),
          ),
          SizedBox(
            height: mheight * 0.03,
          ),
          TextButton(
              onPressed: ()async {
                final credentials = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verificationcode.text);
                try{
                  await auth.signInWithCredential(credentials);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>Home_screen()));
                }catch(e){
                  ToastMessage().toastmessage(message: e.toString());
                }
              },
              child: Container(
                width: mwidth * 0.25,
                height: mheight * 0.06,
                color: Colors.purple,
                child: Center(
                  child: Text(
                    'Verify',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
