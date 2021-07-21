import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget
{
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;



  CustomTextField(
      { required this.controller, required this.data, required this.hintText,required this.isObsecure}
      );



  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding:EdgeInsets.all(4.0),
      margin:EdgeInsets.all(10.0) ,
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(data),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText
        ),
      ),
    );
  }
}
