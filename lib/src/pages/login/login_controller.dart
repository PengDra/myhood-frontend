import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/users_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';

import '../../utils/shared_pref.dart';

///

class LoginController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();
  bool existe = false;
  User userSharedPref = User();

  /// Constructor de la clase.
  /// Recibe el contexto de la aplicación.
  /// El contexto es necesario para mostrar los snackbars.
  /// Durante la inicializacion del controlador se obtiene el usuario que esta guardado en el dispositivo.
  /// Si existe un usuario guardado en el dispositivo, se carga en el controlador.
  /// Si no existe un usuario guardado en el dispositivo, se inicializa el controlador con los valores por defecto.
  /// y es redireccionado a la pagina de login.

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


  /// Metodo que se encarga de iniciar sesion con los datos ingresados.
  /// Se obtiene el usuario de la base de datos con los datos ingresados.
  /// Si el usuario existe se guarda en el dispositivo.
  /// Si el usuario no existe se muestra un snackbar.
  /// Si el usuario existe y tiene un rol se redirecciona a la pantalla de roles.
  /// Si el usuario existe y tiene un solo rol se redirecciona a la pantalla correspondiente(Cliente).

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