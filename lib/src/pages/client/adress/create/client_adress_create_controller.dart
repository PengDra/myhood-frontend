

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myhood/src/pages/client/adress/map/client_adress_map_page.dart';

class ClientAdressCreateController {

  BuildContext context;
  Function refresh;

  TextEditingController refPointController = TextEditingController();
  Map<String, dynamic> refPoint = {};



  Future init(BuildContext context , Function refresh)async{

    this.context = context;
    this.refresh = refresh;
  }
 


  void openMap()async{

    //ESPERA UNA RESPUESTA DE LA PAGINA DE MAPA
    //MIND BLOWN PROBLEM
    refPoint = await showMaterialModalBottomSheet(context: context,
    isDismissible: false,
    enableDrag: false,
    builder:(context) => ClientAdressMapPage());

    if(refPoint != null){
      refPointController.text = refPoint['address'];
      refresh();

    }
  }
}
