import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/store.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/categories_provider.dart';
import 'package:myhood/src/provider/stores_provider.dart';
import 'package:myhood/src/provider/users_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';
import 'package:myhood/src/utils/shared_pref.dart';



/// Clase que controla la vista de crear categoria.
/// Esta opcion solo puede ser seleccionada si el cliente no tiene tienda.
/// Se toman los datos de la tienda y se envian al servidor.


class StoreCategoriesCreateController {
  BuildContext context;
  Function refresh;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider _categoriesProvider = CategoriesProvider();
  UsersProvider usersProvider = UsersProvider();
  StoresProvider storesProvider =  StoresProvider();
  User user;
  Store store;
  SharedPref _sharedPref =  SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _categoriesProvider.init(context);
    storesProvider.init(context);
    usersProvider.init(context);
    user = User.fromJson(await _sharedPref.read('user'));
    //store = Store.fromJson(await _sharedPref.read('store'));
  }

  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Porfavor Ingresa todos los campos');
      return;
    }
    print(user.id);
    
    store = await storesProvider.getStoreByUserId(user.id);
    print(store.id);
    
    

    Categori categori = new Categori(name: name, description: description);
    

    ResponseApi responseApi = await _categoriesProvider.create(categori,store);

    MySnackbar.show(context, responseApi.message);
    if (responseApi?.success) {
      MySnackbar.show(context, 'Categoria creada correctamente');
      nameController.text = '';
      descriptionController.text = '';
    }
  }
   void createCategoryWithStore() async {
   String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Porfavor Ingresa todos los campos');
      return;
    }
    print(user.id);
    
    store = await storesProvider.getStoreByUserId(user.id);
    print(store.id);
    
    

    Categori categori = new Categori(name: name, description: description);


    ResponseApi responseApi = await _categoriesProvider.create(categori,store);

    MySnackbar.show(context, responseApi.message);
    if(responseApi?.success){
      MySnackbar.show(context, 'Categoria creada correctamente');
      nameController.text = '';
      descriptionController.text = '';
    }
  }
  
}
