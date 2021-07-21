import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/Store/storehome.dart';
import 'package:fluttershop/Widgets/customTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final TextEditingController _EmailtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Image.asset(
            'images/login.png',
            height: 150,
            width: 150,
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _formkey,
            child: Column(children: [
              CustomTextField(
                  controller: _EmailtextEditingController,
                  data: Icons.email,
                  hintText: "Enter email",
                  isObsecure: false),
              CustomTextField(
                  controller: _passwordtextEditingController,
                  data: Icons.lock,
                  hintText: "Enter password",
                  isObsecure: false),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.pink,
            ),
            child: TextButton(
                onPressed: () async {
                  if (_EmailtextEditingController.text.isEmpty &&
                      _passwordtextEditingController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Filled are empty",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                  else{
                    try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _EmailtextEditingController.text.trim(),
                      password: _passwordtextEditingController.text.trim(),
                    );
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => StoreHome()));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                  }
                  
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}
