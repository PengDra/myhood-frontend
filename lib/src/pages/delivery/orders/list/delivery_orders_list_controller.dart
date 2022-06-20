import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/delivery/orders/detail/delivery_orders_detail_page.dart';
import 'package:myhood/src/pages/store/orders/detail/store_orders_detail_page.dart';
import 'package:myhood/src/provider/orders_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';

class DeliveryOrdersListController{
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user =new User();

  List<String>status= ['DESPACHADO','EN CAMINO', 'ENTREGADO'];
  OrdersProvider _ordersProvider = new OrdersProvider();

  bool isUpdated = false;

  Future init(BuildContext context, Function refresh)async{
    this.context = context;  
    user = User.fromJson(await _sharedPref.read('user')); 
    _ordersProvider.init(context); 
    this.refresh = refresh;
    refresh();
  }

  Future<List<Order>>getOrders(String status)async{
    return await _ordersProvider.getByDeliveryAndStatus(user.id,status);
  }

  void openBottomSheet(Order order)async{
    isUpdated = await showMaterialModalBottomSheet(context: context, builder: (context)=>DeliveryOrdersDetailPage(order: order ));
    if(isUpdated){
      refresh();
    }
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