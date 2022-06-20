import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:myhood/src/pages/client/orders/detail/client_orders_detail_controller.dart';
import 'package:myhood/src/pages/delivery/orders/detail/delivery_orders_detail_controller.dart';
import 'package:myhood/src/pages/store/orders/detail/store_orders_detail_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';
import 'package:myhood/src/utils/relative_time_util.dart';
import 'package:myhood/src/widgets/no_data_widget.dart';

class ClientOrdersDetailPage extends StatefulWidget {
  Order order;
  ClientOrdersDetailPage({Key key, @required this.order}) : super(key: key);

  @override
  State<ClientOrdersDetailPage> createState() => _ClientOrdersDetailPageState();
}

class _ClientOrdersDetailPageState extends State<ClientOrdersDetailPage> {
  ClientOrdersDetailController _con = ClientOrdersDetailController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Orden ${_con.order?.id ?? ''}'),
          backgroundColor: MyColors.primary,
          elevation: 0,
          actions: [
            Container(
              margin:EdgeInsets.only(top: 15, right: 15),

              child: Text('Total :\$${_con.total}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ),
          ]
        ),
        body: _con.order?.products?.length > 0
            ? ListView(
                children: _con.order.products.map((Product product) {
                  return _cardProduct(product);
                }).toList(),
              )
            : NoDataWidget(text: 'No hay Productos en tu orden '),
        bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    color: Colors.grey,
                    endIndent: 30,
                    indent: 30,
                  ),
                 
                 
                  _textData('Repartidor:  ', '${_con.order?.delivery.name??'No Asignado'} ${_con.order?.delivery.lastname}'),
                 
                  _textData('Entregar en : ','${_con.order.address.address}'),
                 
                  _textData('Fecha de Pedido :','${RelativeTimeUtil.getRelativeTime(_con.order.timestamp??0)}'),                 
                  _con.order?.status=='EN CAMINO' ? _buttonNext():Container(),
                ],
              ),
            )));
  }
  
  Widget _cardProduct(Product product) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(children: [
          _imageProduct(product),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name ?? '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text('Cantidad: ${product.cuantity}' ?? '',
                  style: TextStyle(fontSize: 13, )),
            ],
          ),
        ]));
  }

  Widget _textData(String title, String content) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30,),
        child: ListTile(
          title: Text(title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          subtitle: Text(content,maxLines:2 ,style: TextStyle(fontSize: 18)),
        )
          
        );
  }

 
  Widget _imageProduct(Product product) {
    return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: FadeInImage(
        image: product.image1 != null
            ? NetworkImage(product.image1)
            : AssetImage('assets/img/no-image.png'),
        fit: BoxFit.contain,
        placeholder: AssetImage('assets/img/no-image.png'),
      ),
    );
  }

  Widget _buttonNext() {
    return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 10),
        child: ElevatedButton(
            onPressed: _con.updateOrder,
            style: ElevatedButton.styleFrom(
                primary:MyColors.primary,
                padding: EdgeInsets.symmetric(vertical: 5)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'SEGUIR ENTREGA',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 200),
                    height: 40,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.directions_car,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
              ],
            )));
  }

  void refresh() {
    setState(() {});
  }
}
