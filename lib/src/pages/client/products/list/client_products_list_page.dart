import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myhood/src/pages/client/products/list/clients_products_list_controllers.dart';
import 'package:myhood/src/utils/my_colors.dart';

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
      _con.init(context,refresh);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar:AppBar(
        leading: _menuDrawer(),
        
      ),
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
  Widget _menuDrawer(){
    return GestureDetector(
      onTap:_con.openDrawer,
      child:  Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png',width: 20,height: 20,),

      ),
    );
  }
  Widget _drawer(){
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
            ListTile(
              onTap:_con.goToUpdatePage,
              title:Text('Editar Perfil'),
              trailing: Icon(Icons.edit_outlined),
            ),
            ListTile(
              title:Text('Mis Pedidos'),
              trailing: Icon(Icons.shopping_cart_outlined),
            ),
            //Si el usuario no es null entonces (?)
            _con.user !=null?
            //Si el usuario tiene mas de un rol entonces (?)
            _con.user.roles.length > 1?
            ListTile(
              onTap: _con.goToRoles,
              title:Text('Seleccionar Rol'),
              trailing: Icon(Icons.person_outline),
            ):Container():Container(),
            //Los : equivalen al else del if (?)
            ListTile(
              onTap: _con.logout,
              title:Text('Cerrar Sesión'),
              trailing: Icon(Icons.power_settings_new),
            )

          ],
        ),
      );
    }

    void refresh(){
      setState(() {
        
      });
    }
}
