import 'package:flutter/material.dart';
import 'package:fluttershop/main.dart';

class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return displayAdminHomescreen();
  }
  displayAdminHomescreen(){
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
        leading: IconButton(onPressed: (){},
         icon: Icon(Icons.border_color, color: Colors.white,)
         ),
         actions: [
           TextButton(onPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SplashScreen()));
           },
            child: Text("LogOut", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16.0),)
            )
         ],
      ),
      body: getAdminHomeScreen(),
    );
  }
  getAdminHomeScreen(){
    return Container(
      decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shop_two, color: Colors.white, size: 200.0,),
                Padding(padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  onPressed: (){

                  },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text("Add New Items", style: TextStyle(fontSize: 20.0, color: Colors.white),),
                color: Colors.green,
                ),
                ),
              ],
            ),
          ),
    );
  }
}
