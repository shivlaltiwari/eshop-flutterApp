import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/Admin/uploadItems.dart';
import 'package:fluttershop/Authentication/authenication.dart';
import 'package:fluttershop/Widgets/customTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final TextEditingController _EmailtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  loginAdmin() {
    FirebaseFirestore.instance.collection('admins').get().then((snapshot) {
      snapshot.docs.forEach((result) {
        
        if (result.data()['id'] != _EmailtextEditingController.text.trim()) {
          Fluttertoast.showToast(
              msg: "Admin id not match",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        else if (result.data()['password'] !=
            _passwordtextEditingController.text.trim()) {
          Fluttertoast.showToast(
              msg: "Password donot match",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        else{
           Fluttertoast.showToast(
              msg: "Welcome admin",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            _EmailtextEditingController.text = "";
            _passwordtextEditingController.text = "";
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UploadPage()));
        }


      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink, Colors.blue],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: Text("Admin"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Image.asset(
                'images/admin.png',
                height: 200,
                width: 200,
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
                      hintText: "Enter Admin Id",
                      isObsecure: false),
                  CustomTextField(
                      controller: _passwordtextEditingController,
                      data: Icons.lock,
                      hintText: "Enter password",
                      isObsecure: true),
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
                    onPressed: () {
                      loginAdmin();
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        //onPrimary: Colors.white,
                        shadowColor: Colors.red,
                        onSurface: Colors.white,
                        elevation: 5,
                        shape: const BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AuthenticScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      //color: Colors.blue[50]
                      border: Border(
                          bottom: BorderSide(
                    width: 4,
                    color: Colors.blue,
                  ))),
                  width: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.home_filled,
                        size: 20,
                      ),
                      Text(
                        " Login As User",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
