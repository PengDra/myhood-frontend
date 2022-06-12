import 'package:flutter/material.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/provider/categories_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';

class StoreCategoriesCreateController {
  BuildContext context;
  Function refresh;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider _categoriesProvider = new CategoriesProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _categoriesProvider.init(context);
  }
  void createCategory() async {
    String name =nameController.text;
    String description = descriptionController.text;

    if(name.isEmpty || description.isEmpty){
      MySnackbar.show(context, 'Porfavor Ingresa todos los campos');
      return;
    }

    Categori categori = new Categori(
      name:name,
      description:description
    );
    
    ResponseApi responseApi = await _categoriesProvider.create(categori);

    MySnackbar.show(context, responseApi.message);
    if(responseApi?.success){
      MySnackbar.show(context, 'Categoria creada correctamente');
      nameController.text = '';
      descriptionController.text = '';


    }
  }


}