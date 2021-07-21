import 'package:flutter/material.dart';
import 'package:fluttershop/Authentication/login.dart';
import 'package:fluttershop/Authentication/register.dart';


class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
     child: Scaffold(
       appBar: AppBar(
         flexibleSpace: Container(
           decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.pink, Colors.blue],
            begin: FractionalOffset(0.0,0.0),
            end: FractionalOffset(1.0,0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
           ),
         ),
       ),
       title: Text("Eshop",style: TextStyle(fontSize: 25),),
       centerTitle: true,
       bottom: TabBar(tabs: [
         Tab(
           icon: Icon(Icons.lock,size: 25,),
           text: 'Login',
         ),
         Tab(
           icon: Icon(Icons.perm_contact_calendar_sharp,size: 25,),
           text: 'Register',
         ),
       ],
       indicatorColor: Colors.white,
       indicatorWeight: 5.0,
       ),
     ),
     body: Container(
       decoration: BoxDecoration(
           gradient: LinearGradient(colors: [Colors.pink, Colors.lightBlue],
            begin:Alignment.topLeft,
            end:Alignment.bottomRight,
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
       ),
     ),
     child: TabBarView(children: 
     [
       Login(),
       Register(),
     ]
     ),
     )
     )
    );
  }
}
