import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttershop/Config/config.dart';
import 'package:fluttershop/Widgets/customTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nametextEditingController =
      TextEditingController();
  final TextEditingController _EmailtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final TextEditingController _cpasswordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String imagepath = "";
  final picker = ImagePicker();
  late CollectionReference imgref;
  late firebase_storage.Reference ref;
  late String userImgUrl;

  selectFromGallery() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagepath = PickedFile.path;
      });
    }
  }

  UploadandsaveImage() async {
    // ignore: unnecessary_null_comparison
    if (imagepath == null) {
      Fluttertoast.showToast(
          msg: "Please choose image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _passwordtextEditingController.text ==
              _cpasswordtextEditingController.text
          ?
          // _EmailtextEditingController.text.isEmpty &&
          // _passwordtextEditingController.text.isNotEmpty &&
          // _cpasswordtextEditingController.text.isNotEmpty &&
          // _nametextEditingController.text.isNotEmpty
          uploadToStorage()
          :
          //   Fluttertoast.showToast(
          //     msg: "Fill all the given Filed",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0,
          //  ):
          Fluttertoast.showToast(
              msg: "Password doesnot match",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
    }
    print(_nametextEditingController.text);
    print(_passwordtextEditingController.text);
    print(_cpasswordtextEditingController.text);
    print(_EmailtextEditingController.text);
  }

  uploadToStorage() async {
    ref = firebase_storage.FirebaseStorage.instance.ref().child('user');
    await ref.putFile(File(imagepath)).whenComplete(() async {
      await ref.getDownloadURL().then((url) {
        userImgUrl = url;
        imgref.add({'url': url,
        'name':_nametextEditingController.text.trim(),
        'email':_EmailtextEditingController.text.trim()
        });
        _registerUser();
      });
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    try {
          await _auth.createUserWithEmailAndPassword(
              email: _EmailtextEditingController.text.trim(),
              password: _passwordtextEditingController.text.trim()
              );
          EcommerceApp.sharedPreferences!.setString('name', _nametextEditingController.text.trim());
          EcommerceApp.sharedPreferences!.setString('email', _EmailtextEditingController.text.trim());
       Fluttertoast.showToast(
        msg: "User is create and store in shareprefernce also",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );  
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    imgref = FirebaseFirestore.instance.collection('imageUrl');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: () {
                selectFromGallery();
              },
              child: CircleAvatar(
                radius: 70,
                child: imagepath != ""
                    ? CircleAvatar(
                        radius: 60,
                        child: Image.file(
                          File(imagepath),
                          fit: BoxFit.cover,
                        ))
                    : CircleAvatar(),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nametextEditingController,
                    data: Icons.person,
                    hintText: 'Enter name ',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _EmailtextEditingController,
                    data: Icons.email,
                    hintText: 'Enter your email ',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordtextEditingController,
                    data: Icons.lock,
                    hintText: 'Enter password',
                    isObsecure: true,
                  ),
                  CustomTextField(
                    controller: _cpasswordtextEditingController,
                    data: Icons.lock,
                    hintText: 'Conform password',
                    isObsecure: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              width: 300,
              //color: Colors.lightBlue,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                  onPressed: () {
                    UploadandsaveImage();
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
