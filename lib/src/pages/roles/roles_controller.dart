import 'package:flutter/material.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/utils/shared_pref.dart';

class RolesController{
  BuildContext context;
  Function refresh;

  User user;
  SharedPref sharedPref = new SharedPref();

  /// Recibe la funcion Refresh que actualiza los contenidos de la pantalla.
  /// Recibe el contexto de la aplicación.
  /// Inicializa el usuario que es obtenido desde los shared preferences.

  Future init( BuildContext context, Function refresh )async{
    this.context = context;
    this.refresh = refresh;

    //Obtener el usuario de la sesion 
    user = User.fromJson(await sharedPref.read('user'));
    refresh();
    
  }

  /// Redirecciona dependiendo del valor de route. 
  void goToPage(String route){
    Navigator.pushNamedAndRemoveUntil(context, route,(route)=> false);

  }


}