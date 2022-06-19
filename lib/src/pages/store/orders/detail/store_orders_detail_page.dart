import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:myhood/src/pages/store/orders/detail/store_orders_detail_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';
import 'package:myhood/src/utils/relative_time_util.dart';
import 'package:myhood/src/widgets/no_data_widget.dart';

class StoreOrdersDetailPage extends StatefulWidget {
  Order order;
  StoreOrdersDetailPage({Key key, @required this.order}) : super(key: key);

  @override
  State<StoreOrdersDetailPage> createState() => _StoreOrdersDetailPageState();
}

class _StoreOrdersDetailPageState extends State<StoreOrdersDetailPage> {
  StoreOrdersDetailController _con = StoreOrdersDetailController();

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
        body: _con.order.products.length > 0
            ? ListView(
                children: _con.order.products.map((Product product) {
                  return _cardProduct(product);
                }).toList(),
              )
            : NoDataWidget(text: 'No hay Productos en tu orden '),
        bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    color: Colors.grey,
                    endIndent: 30,
                    indent: 30,
                  ),
                  _textDescription(),
                  _dropdown([]),
                  _textData('Cliente :  ', '${_con.order.client.name} ${_con.order.client.lastname}'),
                 
                  _textData('Entregar en : ','${_con.order.address.address}'),
                 
                  _textData('Fecha de Pedido :','${RelativeTimeUtil.getRelativeTime(_con.order.timestamp??0)}'),
                  
                  //_textTotalPrice(),
                  _buttonNext()
                ],
              ),
            )));
  }
  
  Widget _textDescription(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30,),
      child: Text(
        'Asignar Repartidor',
        style: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
          color: MyColors.primary,
        ),
      ),
    );
    
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

  Widget _dropdown(List<User> users) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [          
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: DropdownButton(
                underline: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_drop_down_circle,
                    color: MyColors.primary,
                  ),
                ),
                elevation: 3,
                isExpanded: true,
                hint: Text(
                  'Selecciona un Repartidor',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                items: _dropDownItems(users),
                //value: _con.idCategory,
                onChanged: (option){
                  setState(() {
                    print('Usuario Seleccionado: $option');
                    //_con.idCategory = option;
                  });
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>>_dropDownItems(List<User>users){
    List<DropdownMenuItem<String>> list =[];

    users.forEach((user) {
      
      list.add(DropdownMenuItem(
        child: Text(user.name),
        value: user.id,
      ));
    });
    return list;

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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                primary: MyColors.primary,
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
                      'Despachar Orden',
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
                      Icons.check_circle,
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
