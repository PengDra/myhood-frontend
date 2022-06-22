import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/store.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/client/upgrade/map/store_adress_map_page.dart';
import 'package:myhood/src/provider/stores_provider.dart';
import 'package:myhood/src/provider/users_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';
import 'package:myhood/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


/// Clase que controla la vista de crear tienda.
/// Se toman los datos de la tienda y se envian al servidor.
/// 

class ClientUpgradeToStoreController {
  BuildContext context;

  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();


  TextEditingController refPointController = TextEditingController();
   Map<String, dynamic> refPoint = {};
   
  UsersProvider usersProvider = new UsersProvider();
  StoresProvider storesProvider = new StoresProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;
  bool isEnabled = true;
  User user;
  Store store;
  
  SharedPref sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);
    usersProvider.init(context);
    storesProvider.init(context);
    user = User.fromJson(await sharedPref.read('user'));
    nameController.text = user.name;
    refresh();
  }

  void createStore() async {
    String name = nameController.text.trim();
    String adress = addressController.text.trim();
    double lat = refPoint['lat'] ?? 0;
    double lng = refPoint['lng'] ?? 0;
    


    if (name.isEmpty || adress.isEmpty||lat == 0 || lng == 0 ) {
      MySnackbar.show(context, "Todos los campos son obligatorios");
      return;
    } 
    _progressDialog.show(max: 100, msg: "Registrando Tienda...");

    
    Store store = new Store(
      name: name,
      address: adress,
      lat: lat,
      lng: lng,
      idUser: user.id,
    );
    user = User.fromJson(await sharedPref.read('user'));
      
    Stream stream = await storesProvider.create(store,user, imageFile);

    stream.listen((res)async {
      _progressDialog.close();
      isEnabled = false;

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message);


      if (responseApi.success) {
        user = await usersProvider.getById(user.id);//Obteniendo datos actualizados desde bd
        print(user.toJson());
        await sharedPref.save('user', user.toJson());
        store = await storesProvider.getStoreByUserId(user.id);//Obteniendo datos actualizados desde bd        
        //Guardando datos actualizados en sharedPref
        await sharedPref.save('store', store);
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        MySnackbar.show(context, responseApi.message);
        isEnabled = true;
      }
    });
  }
  void openMap() async {
    //ESPERA UNA RESPUESTA DE LA PAGINA DE MAPA
    //MIND BLOWN PROBLEM
    refPoint = await showMaterialModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => StoreAdressMapPage());

    if (refPoint != null) {
      refPointController.text = refPoint['address'];
      refresh();
    }
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
