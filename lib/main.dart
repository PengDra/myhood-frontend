import 'package:flutter/material.dart';
import 'package:myhood/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:myhood/src/pages/client/products/list/client_products_list_page.dart';
import 'package:myhood/src/pages/client/update/client_update_page.dart';
import 'package:myhood/src/pages/roles/roles_page.dart';
import 'package:myhood/src/pages/store/categories/create/store_categories_create_pages.dart';
import 'package:myhood/src/pages/store/orders/list/store_orders_list_page.dart';
import 'package:myhood/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:myhood/src/pages/login/login_page.dart';
import 'package:myhood/src/pages/register/register_page.dart';
import 'package:myhood/src/pages/store/products/create/store_products_create_page.dart';

import 'package:myhood/src/utils/my_colors.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({ Key key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyHood',
      initialRoute: 'login',
      routes:{
        'login':(BuildContext context)=>LoginPage(),
        'register':(BuildContext context)=>RegisterPage(),
        'roles':(BuildContext context)=>RolesPage(),
        'client/products/list':(BuildContext context)=>ClientProductsListPage(),
        'client/update':(BuildContext context)=>ClientUpdatePage(),
        'client/orders/create':(BuildContext context)=>ClientOrdersCreatePage(),
        'delivery/orders/list':(BuildContext context)=> DeliveryOrderListPage(),
        'store/orders/list':(BuildContext context)=> StoreOrderListPage(),
        'store/categories/create':(BuildContext context)=>StoreCategoriesCreatePage(),
        'store/products/create':(BuildContext context)=>StoreProductsCreatePage(),
      },
      theme: ThemeData(
        primaryColor: MyColors.primary,
        appBarTheme: AppBarTheme(
          elevation: 0,
          ),
        ),
    );
  }
}

