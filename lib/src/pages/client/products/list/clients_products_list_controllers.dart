import 'package:flutter/material.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/categories_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';

class ClientProductsListController{
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Function refresh;
  User user;


  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  List<Categori> categories = [];

  Future init(BuildContext context, Function refresh)async{
    this.context = context;  
    _categoriesProvider.init(context);
    print('Dentro del init');
    user = User.fromJson(await _sharedPref.read('user')); 
    print(user.toJson()); 
    this.refresh = refresh;
    getCategories(); 
    refresh();
  }
  void getCategories()async{
    categories = await _categoriesProvider.getAll();
    refresh();

  }
  void logout(){
    _sharedPref.logout(context);
  }
  void openDrawer(){
    key.currentState.openDrawer();

  }
  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToUpdatePage(){
    Navigator.pushNamed(context, 'client/update');
  }
  
}