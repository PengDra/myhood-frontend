import 'package:flutter/material.dart';
import 'package:myhood/src/pages/client/adress/create/client_adress_create_page.dart';
import 'package:myhood/src/pages/client/adress/list/client_adress_list_page.dart';
import 'package:myhood/src/pages/client/adress/map/client_adress_map_page.dart';
import 'package:myhood/src/pages/client/orders/confirm/client_orders_confirm_page.dart';
import 'package:myhood/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:myhood/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:myhood/src/pages/client/products/list/client_products_list_page.dart';
import 'package:myhood/src/pages/client/store/list/client_store_list_page.dart';
import 'package:myhood/src/pages/client/update/client_update_page.dart';
import 'package:myhood/src/pages/client/upgrade/todelivery/client_upgrade_to_delivery_page.dart';
import 'package:myhood/src/pages/client/upgrade/tostore/client_upgrade_to_store_page.dart';
import 'package:myhood/src/pages/delivery/orders/map/delivery_orders_map_page.dart';
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


/// Esta es la clase principal de la aplicación.
/// Esta clase es la que se encarga de crear el [MaterialApp] que es el componente principal de la aplicación.
/// Las rutas funcionan de la siguiente manera:
/// - Las rutas de tipo [MaterialPageRoute] son las rutas que se muestran en la aplicación.


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
        'client/store/list':(BuildContext context) => ClientStoreListPage(),
        'client/products/list':(BuildContext context)=>ClientProductsListPage(),
        'client/update':(BuildContext context)=>ClientUpdatePage(),
        'client/orders/create':(BuildContext context)=>ClientOrdersCreatePage(),
        'client/orders/confirm':(BuildContext context)=>ClientOrdersConfirmPage(),
        'client/orders/list':(BuildContext context)=>ClientOrdersListPage(),
        'client/adress/create':(BuildContext context)=>ClientAdressCreatePage(),
        'client/adress/list':(BuildContext context)=>ClientAdressListPage(),
        'client/adress/map':(BuildContext context)=>ClientAdressMapPage(),    
        'client/upgrade/tostore':(BuildContext context)=>ClientUpgradeToStorePage(),
        'client/upgrade/todelivery':(BuildContext context)=>ClientUpgradeToDeliveryPage(),
        'store/orders/list':(BuildContext context)=> StoreOrderListPage(),
        'store/categories/create':(BuildContext context)=>StoreCategoriesCreatePage(),
        'store/products/create':(BuildContext context)=>StoreProductsCreatePage(),
        'delivery/orders/list':(BuildContext context)=> DeliveryOrderListPage(),
        'delivery/orders/map':(BuildContext context)=> DeliveryOrdersMapPage(),
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

