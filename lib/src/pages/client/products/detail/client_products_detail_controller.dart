import 'package:flutter/material.dart';
import 'package:myhood/src/models/product.dart';
class ClientProductsDetailController{

  BuildContext context;
  Function refresh;

  Product product ;

  Future init(BuildContext context, Function refresh, Product product)async{

    this.context = context;
    this.refresh = refresh;
    this.product = product;
    refresh();
  }
}