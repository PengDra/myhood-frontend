import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/pages/client/orders/list/client_orders_list_controller.dart';
import 'package:myhood/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';
import 'package:myhood/src/pages/store/orders/list/store_orders_list_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';
import 'package:myhood/src/widgets/no_data_widget.dart';

class ClientOrdersListPage extends StatefulWidget {
  ClientOrdersListPage({Key key}) : super(key: key);

  @override
  State<ClientOrdersListPage> createState() => _ClientOrdersListPageState();
}

class _ClientOrdersListPageState extends State<ClientOrdersListPage> {
  ClientOrdersListController _con = new ClientOrdersListController();

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
        appBar: PreferredSize(
          
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            title: Text('Mis Pedidos'),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
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
                    if (snapshot.data?.length > 0) {
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
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: Text('Pedido',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    child: Text(
                        '${order.delivery?.name ?? 'No'} ${order.delivery?.lastname ?? ' Asignado'}',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: Text('Entregar en: ${order.address.address ?? ''}',
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
