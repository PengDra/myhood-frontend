import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/store.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:myhood/src/provider/categories_provider.dart';
import 'package:myhood/src/provider/products_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';


/// Esta clase controla la vista de ver todos los productos.
/// Esta clase lista los productos dependiendo del estado de esta.
/// Esta clase muestra el detalle de un producto cuando se interactua con un producto.

class ClientProductsListController {
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user;
  bool showMyStore =false ;
  bool showDelivery=false;
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = new ProductsProvider();
  List<Categori> categories = [];
  Store store ;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _categoriesProvider.init(context);
    _productsProvider.init(context);
    //Obten la tienda desde los shared preferences
    store = ModalRoute.of(context).settings.arguments;
    //guarda la tienda seleccionada en shared pref.
    _sharedPref.save('selectedstore', store);
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
   
    getCategoriesByIdStore(store.id);
    refresh();
  }
  void launchGoogleMaps(Store selectedStore) async {
    //get the store from the database
    
    var url = 'google.navigation:q=${selectedStore.lat.toString()},${selectedStore.lng.toString()}';
    var fallbackUrl =
        'https://www.google.com/maps/search/?api=1&query=${selectedStore.lat.toString()},${selectedStore.lng.toString()}';
    try {
      bool launched =
      await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  Future<List<Product>> getProductsByStore(String idCategory,String idStore) async {
    return await _productsProvider.getByCategory(idCategory);
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await _productsProvider.getByCategory(idCategory);
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }
  void getCategoriesByIdStore(String idStore) async {
    categories = await _categoriesProvider.getByIdStore(idStore);
    refresh();
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
    Navigator.pushNamed(context, 'client/orders/create', arguments: store);
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
