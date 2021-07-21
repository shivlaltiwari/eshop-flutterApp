import 'package:flutter/material.dart';
import 'package:fluttershop/Models/item.dart';
import 'package:fluttershop/Store/cart.dart';
import 'package:fluttershop/Widgets/myDrawer.dart';

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
          title: Text("StoreHome"),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.green,
                  ),
                ),
                Positioned(
                    child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      color: Colors.white,
                      size: 20,
                    ),
                    Positioned(
                      top: 2,
                      left: 4,
                      bottom: 4,
                      child: Text(
                        '1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )
                  ],
                ))
              ],
            )
          ],
        ),
        drawer: MyDrawer(),
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

void checkItemInCart(String productID, BuildContext context) {}
