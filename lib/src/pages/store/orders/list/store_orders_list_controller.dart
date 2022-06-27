import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/models/store.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/store/orders/detail/store_orders_detail_page.dart';
import 'package:myhood/src/provider/orders_provider.dart';
import 'package:myhood/src/provider/stores_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';


/// Esta clase controla la vista de ver todas las ordenes.
/// Esta clase lista las ordenes dependiendo del estado de esta.
/// Esta clase muestra el detalle de la orden cuando es interactuada con ella.
/// Recibe la [Order] que se quiere ver.

class StoreOrdersListController{
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user =new User();
  Store store;

  List<String>status= ['PAGADO','DESPACHADO','EN CAMINO', 'ENTREGADO'];
  OrdersProvider _ordersProvider = new OrdersProvider();
  SharedPref sharedPref = new SharedPref();
  StoresProvider _storesProvider = new StoresProvider();

  String idStore;
  Store myStore;
  bool isUpdated;
   

  Future init(BuildContext context, Function refresh)async{
    this.context = context;  
    this.refresh = refresh;
    _ordersProvider.init(context); 
    _storesProvider.init(context);

    isUpdated = false;
    user = User.fromJson(await _sharedPref.read('user'));
    
    store = await _storesProvider.getStoreByUserId(user.id);//Obteniendo datos actualizados desde bd        
    //Guardando datos actualizados en sharedPref
    sharedPref.save('store', store);
    //Obteniendo la tienda desde los shared pref
    myStore = Store.fromJson(await sharedPref.read('store')) ;
    print('myStore: $myStore');
    isUpdated = true;
    refresh();
  }

  Future<List<Order>>getOrders(String status)async{
    return await _ordersProvider.getByStatus(status);
  }
  Future<List<Order>>getOrdersAndIdStore(String status)async{
    return await _ordersProvider.getByStoreAndStatus(myStore?.id,status);
  }


  void openBottomSheet(Order order)async{
    isUpdated = await showMaterialModalBottomSheet(context: context, builder: (context)=>StoreOrdersDetailPage(order: order ));
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