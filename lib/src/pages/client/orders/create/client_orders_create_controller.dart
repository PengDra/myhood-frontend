import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/store.dart';
import 'package:myhood/src/utils/shared_pref.dart';

/// Clase que controla la vista de crear una orden.
/// Recibe una lista de productos en el [selectedProducts] que obtiene desde los shared preferences.
/// Permite agregar y quitar productos de la orden, ademas de calcular el precio total. 

class ClientOrdersCreateController{

  BuildContext context;
  Function refresh;

  Product product;
  int counter =1;
  int productPrice;

  SharedPref _sharedPref= new SharedPref();
  Store store;

  List<Product> selectedProducts = [];
  int total = 0;

  Future init(BuildContext context, Function refresh)async{

    this.context = context;
    this.refresh = refresh;
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    getTotal();
    //get store from arguments
    store=  ModalRoute.of(context).settings.arguments;
    refresh();
  }
  void getTotal(){
    total = 0;
    selectedProducts.forEach((p){
      total += p.price * p.cuantity;
    });
    refresh();

  }
  void addItem(Product product){
    int index = selectedProducts.indexWhere((p)=>p.id == product.id);
   
    selectedProducts[index].cuantity = selectedProducts[index].cuantity + 1;
    _sharedPref.save('order', selectedProducts);
    getTotal();
       

  }
  void removeItem(Product product){
    if(product.cuantity > 1){
      int index = selectedProducts.indexWhere((p)=>p.id == product.id);
      selectedProducts[index].cuantity = selectedProducts[index].cuantity -1;
      _sharedPref.save('order', selectedProducts);
      getTotal();
    }
    

  }
  void deleteItem(Product product){
    selectedProducts.removeWhere((p) => p.id == product.id);
    _sharedPref.save('order', selectedProducts);
    getTotal();

  }
  void goToAdress(){
    Navigator.pushNamed(context, 'client/adress/list', arguments: store);
  }

}