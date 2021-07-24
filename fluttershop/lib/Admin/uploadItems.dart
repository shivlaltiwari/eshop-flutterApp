import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/Widgets/loadingWidget.dart';
import 'package:fluttershop/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  final picker = ImagePicker();
  //String? imagepath = "";
  TextEditingController descTexteditingController = TextEditingController();
  TextEditingController titleTexteditingController = TextEditingController();
  TextEditingController shotTexteditingController = TextEditingController();
  TextEditingController PriceTexteditingController = TextEditingController();
  String productID =DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;
   File? imagefle;
  String imageUrl = "";

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return imagefle == null
        ? displayAdminHomescreen()
        : uploadAdminFormScreen();
  }

  displayAdminHomescreen() {
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
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.border_color,
              color: Colors.white,
            )),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
              },
              child: Text(
                "LogOut",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ))
        ],
      ),
      body: getAdminHomeScreen(),
    );
  }

  getAdminHomeScreen() {
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
            Icon(
              Icons.shop_two,
              color: Colors.white,
              size: 200.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () {
                  takeImage(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text(
                  "Add New Items",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  takeImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Item Image"),
            children: [
              SimpleDialogOption(
                child: Text("Capture with Camera",
                    style: TextStyle(fontSize: 21, color: Colors.green)),
                onPressed: () {
                  capturewithCamera();
                },
              ),
              SimpleDialogOption(
                child: Text(
                  "Select from Gallery",
                  style: TextStyle(fontSize: 21, color: Colors.green),
                ),
                onPressed: () {
                  selectwithGallery();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cancle",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Icon(
                      Icons.cancel_outlined,
                      size: 20,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  capturewithCamera() async {
    Navigator.pop(context);
    final PickedFile = await picker.getImage(source: ImageSource.camera);
    if (PickedFile != null) {
      setState(() {
       // imagepath = PickedFile.path;
        imagefle = File( PickedFile.path);
      });
    }
  }

  selectwithGallery() async {
    Navigator.pop(context);
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagefle = File( PickedFile.path);
      });
    }
  }

  uploadAdminFormScreen() {
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
      leading: IconButton(
        onPressed: () {
          clearFormInfo();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Add new Product",
        style: TextStyle(
            color: Colors.white, fontSize:20, fontWeight: FontWeight.bold),
      ),
      actions: [
        FlatButton(onPressed:
        () async{
          if(uploading){
            null;
          } else{
            await uploadandSaveInfoProduct();
          }
        },
         child: Text("Add", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Colors.pink),)
         )
      ],
    ),
    body: ListView(
      children: [
        uploading ? circularProgress():Text(""),
        Container(
          height: 230,
          width: MediaQuery.of(context).size.width* 0.8,
          child: Center(
            child: AspectRatio(aspectRatio: 16/9,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(imagefle!)
                ),
               // image: DecorationImage(image: Image.file(File(imagepath!),fit: BoxFit.cover,) as ImageProvider)
              ),
            ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 12)),
        ListTile(
          leading: Icon(Icons.title_outlined, color: Colors.pink,),
          title: Container(
            width: 250,
            child: TextField(
              style: TextStyle(color: Colors.deepPurpleAccent,),
              controller: titleTexteditingController,
              decoration: InputDecoration(
                hintText: "Title ",
                hintStyle: TextStyle(color: Colors.deepPurple),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Divider(color: Colors.deepPurple,),
        ListTile(
          leading: Icon(Icons.perm_device_info, color: Colors.pink,),
          title: Container(
            width: 250,
            child: TextField(
              style: TextStyle(color: Colors.deepPurpleAccent,),
              controller: shotTexteditingController,
              decoration: InputDecoration(
                hintText: "Short info ",
                hintStyle: TextStyle(color: Colors.deepPurple),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Divider(color: Colors.deepPurple,),
        ListTile(
          leading: Icon(Icons.price_change, color: Colors.pink,),
          title: Container(
            width: 250,
            child: TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.deepPurpleAccent,),
              controller: PriceTexteditingController,
              decoration: InputDecoration(
                hintText: "Price",
                hintStyle: TextStyle(color: Colors.deepPurple),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Divider(color: Colors.deepPurple,),
        ListTile(
          leading: Icon(Icons.description, color: Colors.pink,),
          title: Container(
            width: 250,
            child: TextField(
              style: TextStyle(color: Colors.deepPurpleAccent,),
              controller: descTexteditingController,
              decoration: InputDecoration(
                hintText: "Description",
                hintStyle: TextStyle(color: Colors.deepPurple),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Divider(color: Colors.deepPurple,),
      ],

    ),
    );
  }

  clearFormInfo() {
    setState(() {
      imagefle =null;
      titleTexteditingController.clear();
      PriceTexteditingController.clear();
      shotTexteditingController.clear();
      descTexteditingController.clear();
    });
  }
  uploadandSaveInfoProduct() async{
    setState(() {
      uploading = true;
    });
    imageUrl=  await uploadProductImage(imagefle!);
    saveItemInfo(imageUrl);

  }
  Future<String> uploadProductImage(File imagefle) async{
    final Reference ref = FirebaseStorage.instance.ref().child("Items");
     await ref.child("product_$productID.jpg").putFile(File(imagefle.path)).whenComplete(()async{
        imageUrl = (await ref.child("product_$productID.jpg").getDownloadURL()).toString();
      //  await ref.child("Items").getDownloadURL().then((url){
      //    imageUrl = url;
      //  });
     });
      return imageUrl;
    }
    saveItemInfo(String mimageUrl) async{
      final itemRef = FirebaseFirestore.instance.collection("items");
      itemRef.doc(productID).set({
        "shortInfo": shotTexteditingController.text.trim(),
        "longDescription": descTexteditingController.text.trim(),
        "title": titleTexteditingController.text.trim(),
        "price": PriceTexteditingController.text.trim(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": mimageUrl
      });
      Fluttertoast.showToast(
        msg: "Items were Added ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      setState(() {
        imagefle = null;
        uploading = false;
        productID = DateTime.now().millisecondsSinceEpoch.toString();
        descTexteditingController.clear();
        titleTexteditingController.clear();
        PriceTexteditingController.clear();
        shotTexteditingController.clear();

      });



    }
}
