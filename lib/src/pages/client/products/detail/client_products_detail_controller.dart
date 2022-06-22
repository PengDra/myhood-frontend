import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/utils/shared_pref.dart';



///Esta clase muestra el detalle de un producto.
///Permite agregar y quitar productos de la orden, ademas de calcular el precio total de la suma de dicho producto.
///

class ClientProductsDetailController{

  BuildContext context;
  Function refresh;

  Product product ;
  int counter =1;
  int productPrice;

  SharedPref _sharedPref= new SharedPref();

  List<Product> selectedProducts = [];

  Future init(BuildContext context, Function refresh, Product product)async{

    this.context = context;
    this.refresh = refresh;
    this.product = product;
    productPrice = product.price;
    product.cuantity = counter;
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    selectedProducts.forEach((p){
      print('producto seleccionado: ${p.toJson()}');
    });
    refresh();
  }
  void addToBag(){
    int index = selectedProducts.indexWhere((p)=>p.id == product.id);
    if(index == -1){
      if(product.cuantity == null){
        product.cuantity = 1;
      }

      selectedProducts.add(product);
    }else{
      selectedProducts[index].cuantity = counter;
    }
    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg:'Producto agregado al carrito');

  }

  void addItem(){
    counter++;
    productPrice = product.price * counter;
    product.cuantity = counter;
    refresh();
  }
  void removeItem(){
    if(counter > 1){
      counter--;
      productPrice = product.price * counter;
      product.cuantity = counter;
      refresh();
    }
    
  }
  void close(){
    Navigator.pop(context);
  }

}