import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/Authentication/authenication.dart';
import 'package:fluttershop/Config/config.dart';
import 'package:fluttershop/Store/storehome.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink, Colors.blue],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  elevation: 8.0,
                  child: Container(
                    // color: Colors.black,
                    height: 120.0,
                    width: 120,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            EcommerceApp.sharedPreferences!.getString(
                                  EcommerceApp.userAvatarUrl,
                                ) ??
                                "",
                            scale: 1.0)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  EcommerceApp.sharedPreferences!
                          .getString(EcommerceApp.userName) ??
                      " shiva",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink, Colors.blue],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home,color: Colors.white,),
                  title: Text("Home", style: TextStyle(fontSize: 20),),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> StoreHome()));
                  },
                ),
                Divider(thickness: 2,),
                ListTile(
                  leading: Icon(Icons.home,color: Colors.white,),
                  title: Text("My Order", style: TextStyle(fontSize: 20),),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> StoreHome()));
                  },
                ),
                Divider(thickness: 2,),
                ListTile(
                  leading: Icon(Icons.home,color: Colors.white,),
                  title: Text("My Cart", style: TextStyle(fontSize: 20),),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> StoreHome()));
                  },
                ),
                Divider(thickness: 2,),
                ListTile(
                  leading: Icon(Icons.home,color: Colors.white,),
                  title: Text("Search", style: TextStyle(fontSize: 20),),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> StoreHome()));
                  },
                ),
                Divider(thickness: 2,),
                ListTile(
                  leading: Icon(Icons.logout_rounded,color: Colors.white,),
                  title: Text("Logout", style: TextStyle(fontSize: 20),),
                  onTap: ()async{
                    await FirebaseAuth.instance.signOut().then((value){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AuthenticScreen()));
                    });
                  },
                ),
                Divider(thickness: 2,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
