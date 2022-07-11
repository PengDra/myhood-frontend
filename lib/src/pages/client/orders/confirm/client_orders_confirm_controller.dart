import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myhood/src/models/address.dart';
import 'package:myhood/src/models/payment.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/store.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/orders_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';

import '../../../../models/order.dart';

/// Clase que controla la vista de crear una orden.
/// Recibe una lista de productos en el [selectedProducts] que obtiene desde los shared preferences.
/// Permite agregar y quitar productos de la orden, ademas de calcular el precio total. 

class ClientOrdersConfirmController{

  BuildContext context;
  Function refresh;

  Product product;
  int counter =1;
  int productPrice;

  double _distanceBetween;
  int deliveryPrice;
  int usePrice= 300;
  OrdersProvider _ordersProvider = new OrdersProvider();

  SharedPref _sharedPref= new SharedPref();
  User user;
  Store store;
  Order myOrder;
  Address address;

  List<Product> selectedProducts = [];
  int total = 0;

  Future init(BuildContext context, Function refresh)async{
    this.context = context;
    this.refresh = refresh;
    _ordersProvider.init(context); 
    user = User.fromJson(await _sharedPref.read('user'));
    //get the address from shared pref
    address = Address.fromJson(await _sharedPref.read('selectedaddress'));
    //get the selected products from shared pref
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    //get store from shared pref
    store = Store.fromJson(await _sharedPref.read('selectedstore'));
    //get the order from shared pref
    //myOrder = Order.fromJson(await _sharedPref.read('MyOrder'));
    //get the distance between the store and the user
    getDistanceBetween();
    getTotal();
    refresh();
  }
  void getTotal(){
    total = 0;
    selectedProducts.forEach((p){
      total += p.price * p.cuantity;
    });
    total += deliveryPrice + usePrice;
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
  void CreateOrder()async{

    
    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    List<Product> selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    Order order = new Order(
      idClient: user.id,
      idAddress: a.id,
      products: selectedProducts
    );
    //create a payment object
    Payment payment = new Payment(
      idOrder: order.id,
      idDelivery: store.id,
      amount: total.toString()
    );
    ResponseApi response = await _ordersProvider.createWithStoreAndPayment(order, store, payment);
    print('Respuesta: ${response.message}');
    Fluttertoast.showToast(msg: response.message);
    Navigator.pushNamedAndRemoveUntil(context, 'client/store/list', (route) => false);
    

  }

  /// Calcula la distancia entre la direccion de la tienda y la direccion del usuario.
  /// Recibe la direccion de la tienda y la direccion del usuario.
  /// Retorna la distancia en metros.
  /// Se asigna la distancia a variable [_distanceBetween] que se obtiene desde los shared preferences.
  
  void getDistanceBetween(){

    _distanceBetween = Geolocator.distanceBetween(
      store.lat,
      store.lng,
      address.lat,
      address.lng
    );
    //asigna la distancia a la variable deliveryPrice
    //cada kilometro cuesta $300
    deliveryPrice = (_distanceBetween/1000 * 300).toInt();
    //Si la distancia es menor a 1km se asigna el valor de $300
    if(_distanceBetween < 1000){
      deliveryPrice = 300;
    }
}
}