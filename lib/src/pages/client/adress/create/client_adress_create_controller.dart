import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myhood/src/models/address.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/client/adress/map/client_adress_map_page.dart';
import 'package:myhood/src/provider/address_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';
import 'package:myhood/src/utils/shared_pref.dart';

class ClientAdressCreateController {


  BuildContext context;
  Function refresh;

  TextEditingController refPointController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  Map<String, dynamic> refPoint = {};
  AddressProvider _addressProvider = AddressProvider();
  SharedPref _sharedPref= new SharedPref();
  User user;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user= User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context);
    refresh();
  }

  void openMap() async {
    //ESPERA UNA RESPUESTA DE LA PAGINA DE MAPA
    //MIND BLOWN PROBLEM
    refPoint = await showMaterialModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => ClientAdressMapPage());

    if (refPoint != null) {
      refPointController.text = refPoint['address'];
      refresh();
    }
  }

  void createAddress() async {
    String addressName = addressController.text;
    String neighborhood = neighborhoodController.text;
    double lat = refPoint['lat'] ?? 0;
    double lng = refPoint['lng'] ?? 0;

    if (addressName.isEmpty || neighborhood.isEmpty || lat == 0 || lng == 0) {
      MySnackbar.show(context, 'Completa todos los campos');
      return;
    }
    Address address = new Address(
        address: addressName,
        neighborhood: neighborhood, 
        lat: lat,
        lng: lng,
        idUser: user.id
        );

    ResponseApi response = await _addressProvider.create(address);
    if (response.success) {
      address = response.data;
      _sharedPref.save('address', address);
      Fluttertoast.showToast(msg: response.message);
      Navigator.pop(context,true);
    }
    
  }
}
