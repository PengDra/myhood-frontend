import 'package:flutter/material.dart';


/// Esta clase muestra un snackbar con un mensaje.
/// recibe un String con el mensaje.

class MySnackbar{
  static void show(BuildContext context, String text){
   if(context == null)return;
   FocusScope.of(context).requestFocus(new FocusNode());
   ScaffoldMessenger.of(context).removeCurrentSnackBar();
   ScaffoldMessenger.of(context).showSnackBar(
     new SnackBar(
       content: Text(
         text,
         textAlign: TextAlign.center,
         style: TextStyle(
           color: Colors.white,
           fontSize: 16.0,
         ),
        ),
        backgroundColor: Colors.black,
       duration: Duration(seconds: 2),
   ));
  }
}