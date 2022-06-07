import 'package:flutter/material.dart';
import 'package:myhood/src/pages/client/products/list/client_products_list_page.dart';
import 'package:myhood/src/pages/login/login_page.dart';
import 'package:myhood/src/pages/register/register_page.dart';
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
        'client/products/list':(BuildContext context)=>ClientProductsListPage()
      },
      theme: ThemeData(
        primaryColor: MyColors.primary,
      ),
      
    );
  }
}

