import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:myhood/src/provider/categories_provider.dart';
import 'package:myhood/src/provider/products_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';

class ClientProductsListController {
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Function refresh;
  User user;

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = new ProductsProvider();
  List<Categori> categories = [];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    _categoriesProvider.init(context);
    _productsProvider.init(context);
    print('Dentro del init');
    user = User.fromJson(await _sharedPref.read('user'));
    print(user.toJson());
    this.refresh = refresh;
    getCategories();
    refresh();
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await _productsProvider.getByCategory(idCategory);
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
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
    Navigator.pushNamed(context, 'client/orders/create');
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }
}
