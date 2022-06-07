import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myhood/src/pages/client/products/list/clients_products_list_controllers.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key key}) : super(key: key);

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ClientProductsListController _con =new ClientProductsListController();
  
  void innitState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _con.init(context);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _con.logout,
          child: Text(
            'Cerrar Sesión',
          ),
        ),
      ),
    );
  }
}
