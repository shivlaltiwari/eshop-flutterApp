import 'package:flutter/material.dart';
import 'package:fluttershop/Models/item.dart';


class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    //double widt = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("StoreHome"),
        ),
      ),
    );
  }
}



Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background = Colors.red, removeCartFunction}) {
  return InkWell();
}



Widget card({Color primaryColor = Colors.redAccent, String? imgPath}) {
  return Container();
}



void checkItemInCart(String productID, BuildContext context)
{
}
