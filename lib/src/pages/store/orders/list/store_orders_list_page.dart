import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/pages/store/orders/list/store_orders_list_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';
import 'package:myhood/src/widgets/no_data_widget.dart';

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
    return DefaultTabController(
      length: _con.status.length,
      child: Scaffold(
        key: _con.key,
        drawer: _drawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            flexibleSpace: Column(
              children: [],
            ),
            bottom: TabBar(
                indicatorColor: MyColors.primary,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[400],
                isScrollable: true,
                tabs: List<Widget>.generate(_con.status.length, (index) {
                  return Tab(
                    child: Text(_con.status[index] ?? ''),
                  );
                })),
          ),
        ),
        body: TabBarView(
          children: _con.status.map((String status) {
            return FutureBuilder(
                future: _con.getOrders(status),
                builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return ListView.builder(
                         
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardOrder(snapshot.data[index]);
                          });
                    } else {
                      return NoDataWidget(text: 'No hay ordenes');
                    }
                  } else {
                    return NoDataWidget(text: 'No hay ordenes');
                  }
                });
          }).toList(),
        ),
      ),
    );
  }

  Widget _cardOrder(Order order) {
    return GestureDetector(
      onTap: () {
        _con.openBottomSheet(order);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 160,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 30,
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "Orden #${order.id} ",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              Container(
                
              margin: EdgeInsets.only(top:40,left: 20,right:20),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical:5),
                    alignment: Alignment.centerLeft,
                      width: double.infinity,
                    child: Text('Pedido',
                     
                        style:
                            TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                   Container(
                    
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical:5),
                      width: double.infinity,
                     child: Text('${order.client?.name??''} ${order.client?.lastname??''}',
                      
                        maxLines: 1,
                        style:
                            TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                   ),
                    
                     Container(
                      margin: EdgeInsets.symmetric(vertical:5),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Text('Entregar en: ${order.address.address??''}',
                      
                        maxLines: 2,
                        style:
                            TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                ]),
              ),
            ],
          ),
        ),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '${_con.user?.name ?? ' '} ${_con.user?.lastname ?? ' '}',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              Text(
                '${_con.user?.email ?? ' '}',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                maxLines: 1,
              ),
              Text(
                '${_con.user?.phone ?? ' '}',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                maxLines: 1,
              ),
              Container(
                height: 60,
                child: FadeInImage(
                  image: _con.user?.image != null
                      ? NetworkImage(_con.user?.image)
                      : AssetImage('assets/img/no-image.png'),
                  fit: BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'),
                ),
              ),
            ]),
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
