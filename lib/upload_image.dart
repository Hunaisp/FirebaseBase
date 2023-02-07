import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example1/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

File? _image;

final picker = ImagePicker();
DatabaseReference databaseReference = FirebaseDatabase.instance.ref('post');
firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage
    .instance;

class _UploadImageState extends State<UploadImage> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Upload Your Image',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          getGalleryImage();
        },
        child: Padding(
          padding: EdgeInsets.all(mwidth * 0.05),
          child: Column(
            children: [
              Container(
                width: mwidth * 0.35,
                height: mheight * 0.15,
                child: _image != null
                    ? Image.file(
                  _image!.absolute,
                  fit: BoxFit.cover,
                )
                    : Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: mheight * 0.03,
              ),
              TextButton(
                  onPressed: () async{
                    final id=DateTime.now().microsecondsSinceEpoch.toString();
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance.ref('/foldername/' + id);
                    firebase_storage.UploadTask uploadtask=ref.putFile(_image!.absolute);
                    await Future.value(uploadtask).then((value)async{
                      var newUrl= await ref.getDownloadURL();
                      print(newUrl.toString());
                      databaseReference.child(id).set({
                        'id':id,
                        'title':newUrl.toString()
                      }).then((value) => ToastMessage().toastmessage(message: 'Uploaded'));
                    });




                  },
                  child: Text(
                    'Upload',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w400),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getGalleryImage() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image found');
      }
    });
  }
}
