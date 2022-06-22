import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/orders_provider.dart';
import 'package:myhood/src/provider/users_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';
import 'package:myhood/src/utils/shared_pref.dart';

/// En esta clase se controla la vista de ver una orden.
/// Se recibe una [Orden] desde los parametros de la creacion de la vista.
/// Permite ver la cantidad de productos, el precio total de la orden.
/// La tienda puede seleccionar un delivery para realizar la entrega.
class StoreOrdersDetailController{

  BuildContext context;
  Function refresh;

  Product product;
  int counter =1;
  int productPrice;
  Order order;
  User user;

  SharedPref _sharedPref= new SharedPref();
  List<User> users = [];
  UsersProvider _usersProvider = new UsersProvider();
  OrdersProvider _ordersProvider = new OrdersProvider();
  String idDelivery;

  
  int total = 0;

  

  Future init(BuildContext context, Function refresh,Order order)async{

    this.context = context;
    this.refresh = refresh;
    this.order = order;
    user =  User.fromJson(await _sharedPref.read('user'));
    _ordersProvider.init(context);
    _usersProvider.init(context);
    getTotal(); 
    getUsers();
    refresh();
  }
  void getUsers()async{
    users = await _usersProvider.getDeliveryMan();
    refresh();
  }
  void getTotal(){
    total = 0;
    order.products.forEach((product){
      total = total +(product.price*product.cuantity);
    });
    
    refresh();
  }

void updateOrder()async{

  if(idDelivery != null){
    order.idDelivery = idDelivery;
    ResponseApi responseApi = await _ordersProvider.updateToDispatched(order);
    Fluttertoast.showToast(msg: responseApi.message, toastLength: Toast.LENGTH_LONG);
    Navigator.pop(context,true);

  }else{
    Fluttertoast.showToast(msg: 'Selecciona un delivery');
  }

 }
 }