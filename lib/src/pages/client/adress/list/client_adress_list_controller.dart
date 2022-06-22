import 'package:flutter/material.dart';
import 'package:myhood/src/models/address.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/address_provider.dart';
import 'package:myhood/src/provider/orders_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';

class ClientAdressListController {
  BuildContext context;
  Function refresh;
  List<Address> address = [];
  AddressProvider _addressProvider = AddressProvider();
  User user;
  SharedPref _sharedPref = new SharedPref();
  int radioValue = 0;
  bool isCreated = false;
  OrdersProvider _ordersProvider= new OrdersProvider();
  


  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context);
    _ordersProvider.init(context);
    refresh();
  }

  void goToNewAdress() async {
    var result = await Navigator.pushNamed(context, 'client/adress/create');
    if (result != null) {
      if (result) {
        refresh();
      }
    }
  }

  /// Obtiene las direcciones del usuario.
  

  Future<List<Address>> getAdress() async {
    
    try{
      address = await _addressProvider.getByUser(user.id);
    }catch(e){
      print(e);
      print(e.stackTrace);
    }
    
    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    int index = address.indexWhere((ad) => ad.id== a.id);
    if (index != -1) {
      radioValue = index;
    }
    return address;
  }

  /// Obtiene los productos de una orden.
  /// Recibe el id de la orden.
  /// Recibe una lista de productos en el [selectedProducts] que obtiene desde los shared preferences.
  /// Retorna una lista de productos.
  /// Se asigna la lista al objeto [order] que se obtiene desde los shared preferences.
  /// se crea una nueva orden en la BD.
  void createOrder()async{
    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    List<Product> selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    Order order = new Order(
      idClient: user.id,
      idAddress: a.id,
      products: selectedProducts
    );
    ResponseApi response = await _ordersProvider.create(order);
    print('Respuesta: ${response.message}');
  }

  /// maneja el valor del radio button.
  void handleRadioValueChange(int value) async {
    radioValue = value;
    _sharedPref.save('address', address[value]);
    refresh();
  }
}
