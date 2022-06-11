import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/users_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';

import '../../utils/shared_pref.dart';

class LoginController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();
  bool existe = false;
  User userSharedPref = User();


  Future init(BuildContext context)async {
    this.context = context;
    await usersProvider.init(context);
    //print the content of the shared preferences
    print(await _sharedPref.read('user'));
    //Buscar datos en el shared preferences si es null llena un mapa vacio 
    //User user = User.fromJson(await _sharedPref.read('user')) ?? {};
    if(existe =await _sharedPref.exist('user')){
      User userSharedPref = User.fromJson(await _sharedPref.read('user'))?? User();
       //Si el usuario no esta vacio se carga la pantalla automaticamente desde el session token
      //El ? revisa si el usuario esta null
      if(userSharedPref?.sessionToken != null){
      if(userSharedPref.roles.length > 1){
          //Si usuario tiene mas de un rol se redirecciona a la pantalla de roles
          Navigator.pushNamedAndRemoveUntil(context, 'roles',((route) => false));
        }else{
          //Redirecciona y elimina las pantallas anteriores  
          Navigator.pushNamedAndRemoveUntil(context,userSharedPref.roles[0].route, (route) => false);
        }
      }
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }
  void login()async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);
    if(responseApi.success){
      //Si logra hacer login guarda el token en el shared preferences
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      bool existe =await _sharedPref.exist('user');
      print(existe);
      
      if(user.roles.length > 1){
        //Si usuario tiene mas de un rol se redirecciona a la pantalla de roles
        Navigator.pushNamedAndRemoveUntil(context, 'roles',((route) => false));
      }else{
        //Redirecciona y elimina las pantallas anteriores  
        Navigator.pushNamedAndRemoveUntil(context,user.roles[0].route, (route) => false);
      }

      
    }else{
      MySnackbar.show(context, responseApi.message);
    }
    
  }

}