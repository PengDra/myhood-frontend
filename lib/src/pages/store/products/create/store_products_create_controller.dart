import 'package:flutter/material.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/provider/categories_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';

class StoreProductsCreateController {
  BuildContext context;
  Function refresh;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  List<Categori> categories = [];
  String idCategory;
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _categoriesProvider.init(context);
    getCategories();
    
  }
  void getCategories()async{
    
    categories = await _categoriesProvider.getAll();
    refresh();
  }
  void createProduct() async {
    String name =nameController.text;
    String description = descriptionController.text;

    if(name.isEmpty || description.isEmpty){
      MySnackbar.show(context, 'Porfavor Ingresa todos los campos');
      return;
    }
  }


}