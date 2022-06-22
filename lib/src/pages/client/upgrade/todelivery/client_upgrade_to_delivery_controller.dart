import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/users_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';
import 'package:myhood/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

/// Clase que controla la vista de actualizar un usuario y asignar el rol de Repartidor.

class ClientUpgradeToDeliveryController {
  BuildContext context;

  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();

  TextEditingController phoneController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;
  bool isEnabled = true;
  User user;
  SharedPref sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);
    usersProvider.init(context);
    user = user = User.fromJson(await sharedPref.read('user'));
    nameController.text = user.name;
    lastNameController.text = user.lastname;
    phoneController.text = user.phone;
    refresh();
  }

  void update() async {
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isEmpty || lastName.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, "Todos los campos son obligatorios");
      return;
    }
    _progressDialog.show(max: 100, msg: "Registrando usuario...");

    User myUser = new User(
      id: user.id,
      name: name,
      lastname: lastName,
      phone: phone,
      image: user.image
    );

    Stream stream = await usersProvider.update(myUser, imageFile);

    stream.listen((res)async {
      _progressDialog.close();
      isEnabled = false;

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message);

      if (responseApi.success) {
        user = await usersProvider.getById(myUser.id);//Obteniendo datos actualizados desde bd
        print(user.toJson());
        await sharedPref.save('user', user.toJson());//Guardando datos actualizados en sharedPref
        Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
      } else {
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
