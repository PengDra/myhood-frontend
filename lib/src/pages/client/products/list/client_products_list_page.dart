import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/rol.dart';
import 'package:myhood/src/models/store.dart';
import 'package:myhood/src/pages/client/products/list/clients_products_list_controllers.dart';
import 'package:myhood/src/utils/my_colors.dart';
import 'package:myhood/src/widgets/no_data_widget.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key key}) : super(key: key);
  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ClientProductsListController _con = new ClientProductsListController();
  Store store = new Store();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
      //get the store from the parameters
      store = ModalRoute.of(context).settings.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.categories.length,
      child: Scaffold(
        key: _con.key,
        drawer: _drawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            //leading:_menuDrawer(),
            actions: [
              _shopingBag(),
            ],
            flexibleSpace: Column(
              children: [
                SizedBox(
                  height: 64,
                ),
                _IconGoogleMaps(),
                Text(
                  store.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                
              ],
            ),
            bottom: TabBar(
                indicatorColor: MyColors.primary,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[400],
                isScrollable: true,
                tabs: List<Widget>.generate(_con.categories.length, (index) {
                  return Tab(
                    child: Text(_con.categories[index].name ?? ''),
                  );
                })),
          ),
        ),
        body: TabBarView(
          children: _con.categories.map((Categori categori) {
            return FutureBuilder(
                future: _con.getProducts(categori.id),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.7),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardProduct(snapshot.data[index]);
                          });
                    } else {
                      return NoDataWidget(text: 'No hay productos');
                    }
                  } else {
                    return NoDataWidget(text: 'No hay productos');
                  }
                });
          }).toList(),
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

  Widget _shopingBag() {
    return GestureDetector(
      onTap:_con.goToOrderCreatePage,
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(right: 20, top: 13),
              child: Icon(Icons.shopping_bag_outlined, color: Colors.black)),
          Positioned(
              right: 16,
              top: 15,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
              ))
        ],
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return GestureDetector(
      onTap:(){
        _con.openBottomSheet(product);

      } ,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 250,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                  top: -1.0,
                  left: -1.0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: MyColors.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  height: 150,
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.45,
                  padding: EdgeInsets.all(20),
                  child: FadeInImage(
                    image: product.image1 != null
                        ? NetworkImage(product.image1)
                        : AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.contain,
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 33,
                  child: Text(
                    product.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    '${product.price ?? ''}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ])
            ],
          ),
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
          ListTile(
            onTap: _con.goToUpdatePage,
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            onTap: _con.goToOrderListPage,
            title: Text('Mis Pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
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
          //Si el usuario no es null entonces (?)
          _con.user != null
              ?
              //Si el usuario tiene mas de un rol entonces (?)
                _con.showMyStore
                  ? ListTile(
                      onTap: _con.goToRoles,
                      title: Text('Mi Tienda'),
                      trailing: Icon(Icons.store_mall_directory_sharp),
                    )
                  : ListTile(
                      onTap: _con.goToUpgradeToStorePage,
                      title: Text('Crear Tienda'),
                      trailing: Icon(Icons.store_mall_directory_sharp),
                    )
              : Container(),
          //Los : equivalen al else del if (?)
          //Si el usuario no es null entonces (?)
          _con.user != null
              ?
              //Si el usuario tiene mas de un rol entonces (?)
                _con.showDelivery
                  ? ListTile(
                      onTap: _con.goToRoles,
                      title: Text('Mis Repartos'),
                      trailing: Icon(Icons.bike_scooter_outlined),
                    )
                  : ListTile(
                      onTap: _con.goToUpgradeToDeliveryPage,
                      title: Text('Trabajar como delivery'),
                      trailing: Icon(Icons.bike_scooter_outlined),
                    )
              : Container(),
          //Los : equivalen al else del if (?)
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar Sesión'),
            trailing: Icon(Icons.power_settings_new),
          )
        ],
      ),
    );
  }
  Widget _IconGoogleMaps(){
    return GestureDetector(
      onTap:(){_con.launchGoogleMaps(store);},
      child: Container(
        child: Image.asset('assets/img/google_maps.png'),
        height:40,
        width:40,
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
