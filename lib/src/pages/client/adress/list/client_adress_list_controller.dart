import 'package:flutter/material.dart';

class ClientAdressListController {

  BuildContext context;
  Function refresh;


  Future init(BuildContext context , Function refresh)async{

    this.context = context;
    this.refresh = refresh;

  }
  void goToNewAdress(){
    Navigator.pushNamed(context, 'client_adress_create');
  }

}
