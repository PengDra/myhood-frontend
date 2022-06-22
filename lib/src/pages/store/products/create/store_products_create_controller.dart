import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/store.dart';
import 'package:myhood/src/provider/categories_provider.dart';
import 'package:myhood/src/provider/products_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';
import 'package:myhood/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'dart:convert';

class StoreProductsCreateController {
  BuildContext context;
  Function refresh;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = new ProductsProvider();
  List<Categori> categories = [];
  Store store;

  //Imagenes
  PickedFile pickedFile;
  File imageFile1;
  File imageFile2;
  File imageFile3;

  ProgressDialog _progressDialog;
  SharedPref _sharedPref = new SharedPref();

  bool isLoading = false;
  String idCategory;
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    store = Store.fromJson(await _sharedPref.read('store')); 
    _progressDialog = ProgressDialog(context: context);
    _categoriesProvider.init(context);
    _productsProvider.init(context);
    getCategories();
    
  }
  void getCategories()async{
    
    categories = await _categoriesProvider.getByIdStore(store.id);
    refresh();
  }
  void createProduct() async {
    String name =nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;

    if(name.isEmpty || description.isEmpty || price.isEmpty || price == '0'){
      MySnackbar.show(context, 'Porfavor Ingresa todos los campos');
      return;
    }
    if(imageFile1 == null || imageFile2 == null || imageFile3 == null){
      MySnackbar.show(context, 'Porfavor selecciona 3 imagenes');
      return;
    }
    if(idCategory == null){
      MySnackbar.show(context, 'Porfavor selecciona una categoria');
      return;
    }
    Product product = new Product(
      name: name,
      description: description,
      price: int.parse(price) ,
      idCategory: int.parse(idCategory),
      image1: imageFile1.path,
      image2: imageFile2.path,
      image3: imageFile3.path,
    );
    List<File> images = [];
    images.add(imageFile1);
    images.add(imageFile2);
    images.add(imageFile3);
    _progressDialog.show(max: 100, msg: 'Creando Producto');


    Stream stream = await _productsProvider.create(store,product, images);

    stream.listen((res) {
      _progressDialog.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context, responseApi.message);

      if(responseApi.success){
        resetValues();
      }else{
        _progressDialog.close();
      }
    });

    print(product.toJson());

  }
  void resetValues(){
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    idCategory = null;
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory = null;
    refresh();
  }
  
  Future selectImage(ImageSource imageSource,int numberfile) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      if(numberfile==1){
        imageFile1 = File(pickedFile.path);
      } else if(numberfile==2){
        imageFile2 = File(pickedFile.path);
      } else if(numberfile==3){
        imageFile3 = File(pickedFile.path);
      }
      
      
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int numberfile) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.gallery,numberfile);
      },
      child: Text('Galeria'),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.camera,numberfile);
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


}