import 'package:flutter/material.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/users_provider.dart';

class RegisterController{
  BuildContext context;


  TextEditingController emailController= new TextEditingController();
  TextEditingController nameController= new TextEditingController();
  TextEditingController lastNameController= new TextEditingController();
  TextEditingController rutController= new TextEditingController();
  TextEditingController phoneController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  TextEditingController confirmPasswordController= new TextEditingController();
  
  UsersProvider usersProvider=new UsersProvider();
  
  Future init(BuildContext context){
    this.context = context;
    usersProvider.init(context);
  }
  void register() async {


    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String rut = rutController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    User user = new User(
      email: email,
      name: name,
      lastname: lastName,
      rut: rut,
      phone: phone,
      password: password,
    );
    ResponseApi responseApi = await usersProvider.create(user);

    print('Respuesta : ${responseApi.toJson()}');
  }


}