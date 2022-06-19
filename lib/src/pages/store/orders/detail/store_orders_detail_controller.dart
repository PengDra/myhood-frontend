import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/utils/shared_pref.dart';


class StoreOrdersDetailController{

  BuildContext context;
  Function refresh;

  Product product;
  int counter =1;
  int productPrice;
  Order order;

  SharedPref _sharedPref= new SharedPref();

  
  int total = 0;

  Future init(BuildContext context, Function refresh,Order order)async{

    this.context = context;
    this.refresh = refresh;
    this.order = order;
   
    getTotal();
    
    refresh();
  }
  void getTotal(){
    total = 0;
    order.products.forEach((product){
      total = total +(product.price*product.cuantity);
    });
    
    refresh();

  }

  
}