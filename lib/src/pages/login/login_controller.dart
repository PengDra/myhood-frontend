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


  Future init(BuildContext context)async {
    this.context = context;
    await usersProvider.init(context);
    //Buscar datos en el shared preferences si es null llena un mapa vacio
    User user = await _sharedPref.read('user') ??{};
    //Si el usuario no esta vacio se carga la pantalla automaticamente desde el session token
    //El ? revisa si el usuario esta null
    if(user?.sessionToken != null){
      Navigator.pushNamedAndRemoveUntil(context,'client/products/list', (route) => false);
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
      //Redirecciona y elimina las pantallas anteriores
      Navigator.pushNamedAndRemoveUntil(context,'client/products/list', (route) => false);

    }else{
      MySnackbar.show(context, responseApi.message);
    }
    
  }

}