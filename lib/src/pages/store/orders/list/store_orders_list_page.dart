import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myhood/src/pages/store/orders/list/store_orders_list_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';

class StoreOrderListPage extends StatefulWidget {
  StoreOrderListPage({Key key}) : super(key: key);

  @override
  State<StoreOrderListPage> createState() => _StoreOrderListPageState();
}

class _StoreOrderListPageState extends State<StoreOrderListPage> {
  StoreOrdersListController _con = new StoreOrdersListController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
        //leading: _menuDrawer(),
      ),
      body: Center(
        child: Text('StoreOrderListPage'),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/img/menu.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: MyColors.primary,
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${_con.user?.name??' '} ${_con.user?.lastname??' '}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text('${_con.user?.email??' '}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Text('${_con.user?.phone??' '}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    child: FadeInImage(
                      image:_con.user?.image != null? NetworkImage(_con.user?.image) :AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),       
                  ),   
                ]
              ),
            ),
          //Si el usuario no es null entonces (?)
          _con.user != null
              ?
              //Si el usuario tiene mas de un rol entonces (?)
              _con.user.roles.length > 1
                  ? ListTile(
                      onTap: _con.goToRoles,
                      title: Text('Seleccionar Rol'),
                      trailing: Icon(Icons.person_outline),
                    )
                  : Container()
              : Container(),
          //Los : equivalen al else del if (?)
          ListTile(
            onTap: _con.goToCategoryCreate,
            title: Text('Crear Categoria'),
            trailing: Icon(Icons.list_alt),
          ),
          ListTile(
            onTap: _con.goToProductCreate,
            title: Text('Crear Productos'),
            trailing: Icon(Icons.emoji_food_beverage_outlined),
          ),

          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar Sesión'),
            trailing: Icon(Icons.power_settings_new),
          )
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
