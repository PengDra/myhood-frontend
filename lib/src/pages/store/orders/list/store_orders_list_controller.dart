import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/store/orders/detail/store_orders_detail_page.dart';
import 'package:myhood/src/provider/orders_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';

class StoreOrdersListController{
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user;

  List<String>status= ['PAGADO','DESPACHADO','EN CAMINO', 'ENTREGADO'];
  OrdersProvider _ordersProvider = new OrdersProvider();

  Future init(BuildContext context, Function refresh)async{
    this.context = context;  
    user = User.fromJson(await _sharedPref.read('user')); 
    _ordersProvider.init(context); 
    this.refresh = refresh;
    refresh();
  }

  Future<List<Order>>getOrders(String status)async{
    return await _ordersProvider.getByStatus(status);
  }

  void openBottomSheet(Order order){
    showMaterialModalBottomSheet(context: context, builder: (context)=>StoreOrdersDetailPage(order: order ));

  }
  void logout(){
    _sharedPref.logout(context);
  }
  void goToCategoryCreate(){
    Navigator.pushNamed(context, 'store/categories/create');
  }
  void goToProductCreate(){
    Navigator.pushNamed(context, 'store/products/create');
  }
  void openDrawer(){
    key.currentState.openDrawer();

  }
  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
  
}