import 'package:flutter/material.dart';

class ClientAdressCreateController {

  BuildContext context;
  Function refresh;


  Future init(BuildContext context , Function refresh)async{

    this.context = context;
    this.refresh = refresh;

  }
}
