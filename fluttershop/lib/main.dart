import 'dart:async';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/Authentication/authenication.dart';
//import 'package:fluttershop/Authentication/login.dart';
import 'package:fluttershop/Config/config.dart';
import 'package:fluttershop/Store/storehome.dart';
//import 'package:fluttershop/Store/storehome.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: 'e-Shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.green,
            ),
            home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState() {
    super.initState();
    displaySplash();
  }
  displaySplash(){
    Timer(Duration(seconds: 5), () async{
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthenticScreen()));
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StoreHome()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthenticScreen()));
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.pink, Colors.blue],
          begin: FractionalOffset(0.0,0.0),
          end: FractionalOffset(1.0,0.0),
          stops: [0.0,1.0],
          tileMode: TileMode.clamp
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/welcome.png'),
              SizedBox(height: 20,),
              Text("Flutter Demo Eshop", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      )
    );
  }
}
