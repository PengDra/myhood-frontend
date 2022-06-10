import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/users_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController {  
  BuildContext context;

  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController rutController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;
  bool isEnabled = true;


  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);
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

    if (email.isEmpty ||
        name.isEmpty ||
        lastName.isEmpty ||
        rut.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context, "Todos los campos son obligatorios");
      return;
    }

    if (password != confirmPassword) {
      MySnackbar.show(context, "Las contraseñas no coinciden");
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(
          context, "La contraseña debe tener al menos 6 caracteres");
      return;
    }
    if (imageFile == null) {
      MySnackbar.show(context, "Debe seleccionar una imagen");
      return;
    }
    _progressDialog.show(max: 100, msg: "Registrando usuario...");

    User user = new User(
      email: email,
      name: name,
      lastname: lastName,
      rut: rut,
      phone: phone,
      password: password,
    );

    Stream stream = await usersProvider.createWithImage(user, imageFile);

    stream.listen((res) {

      _progressDialog.close();
      isEnabled = false;


      //ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, 'login');
        });
      }else{
        MySnackbar.show(context, responseApi.message);
        isEnabled = true;
      }
    });
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.gallery);
      },
      child: Text('Galeria'),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.camera);
      },
      child: Text('Camara'),
    );
    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void back() {
    Navigator.pop(context);
  }
}
