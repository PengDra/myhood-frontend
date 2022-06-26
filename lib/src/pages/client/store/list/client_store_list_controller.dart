
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/store.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:myhood/src/provider/categories_provider.dart';
import 'package:myhood/src/provider/products_provider.dart';
import 'package:myhood/src/provider/stores_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';


/// Esta clase controla la vista de ver todos los productos.
/// Esta clase lista los productos dependiendo del estado de esta.
/// Esta clase muestra el detalle de un producto cuando se interactua con un producto.

class ClientStoreListController {
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Function refresh;
  User user;
  bool showMyStore =false ;
  bool showDelivery=false;
  StoresProvider _storesProvider = new StoresProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _storesProvider.init(context);
    print('Dentro del init');
    user = User.fromJson(await _sharedPref.read('user'));
    user.roles.forEach((element) {
      if(element.name == "STORE"){
        showMyStore = true;
      }
    });
    user.roles.forEach((element) {
      if(element.name == "DELIVERY"){
        showDelivery = true;
      }
    });
    print(user.toJson());
    this.refresh = refresh;
    getStores();
    refresh();
  }

  Future<List<Store>> getStores() async {
    return await _storesProvider.getAll();
  }

  void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
        context: context, builder: (context) => ClientProductsDetailPage(product: product));
  }

  void logout() {
    _sharedPref.logout(context);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
  void goToOrderCreatePage() {
    Navigator.pushNamed(context, 'client/orders/create');
  }
  void goToOrderListPage() {
    Navigator.pushNamed(context, 'client/orders/list');
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }
  void goToUpgradeToStorePage() {
    Navigator.pushNamed(context, 'client/upgrade/tostore');
  }
  void goToUpgradeToDeliveryPage() {
    Navigator.pushNamed(context, 'client/upgrade/todelivery');
  }
}
