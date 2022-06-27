import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';
import 'package:myhood/src/widgets/no_data_widget.dart';

class ClientOrdersCreatePage extends StatefulWidget {
  const ClientOrdersCreatePage({Key key}) : super(key: key);

  @override
  State<ClientOrdersCreatePage> createState() => _ClientOrdersCreatePageState();
}

class _ClientOrdersCreatePageState extends State<ClientOrdersCreatePage> {
  ClientOrdersCreateController _con = ClientOrdersCreateController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mi Orden'),
          backgroundColor: MyColors.primary,
          elevation: 0,
        ),
        body: _con.selectedProducts.length > 0
            ? ListView(
                children: _con.selectedProducts.map((Product product) {
                  return _cardProduct(product);
                }).toList(),
              )
            : NoDataWidget(text: 'No hay Productos en tu orden '),
        bottomNavigationBar:Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child:Column(
            children: [
              Divider(
                color: Colors.grey,
                endIndent: 30,
                indent: 30,
              ),
              _textTotalPrice(),
              _buttonNext()
            ],
          )

        )
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
          Text(product.name?? ''
              ,maxLines: 1,
              overflow: TextOverflow.ellipsis,
               style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold)
              ),
          SizedBox(height: 5),
          _addOrRemoveItem(product),
          _iconDelete(product)
             
        ],
      ),
      Spacer(),
      Column(
        children:[
          _textPrice(product)
        ]
      )
    ]));
  }
  Widget _textTotalPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
       child: Row(
      children:[
        Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Spacer(),
        Text(
          '${_con.total}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          )
       

      ]
    )

    );
   
  }
  Widget _iconDelete(Product product){
    return IconButton(onPressed: (){
      _con.deleteItem(product);
    },icon: Icon(Icons.delete, color: MyColors.primary, size: 30,),);
  }
  Widget _textPrice(Product product){
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Text('${product.price * product.cuantity }',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: MyColors.primary)
            ),
    );
  }
  Widget _imageProduct(Product product){
   return  Container(
        width: 90,
        height: 90,
        padding: EdgeInsets.all(10),
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
  Widget _addOrRemoveItem(Product product){
    return  Row(
                children:[
                  GestureDetector(
                    onTap: (){
                      _con.removeItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:12,vertical:5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))
                      ),
                      child: Text('-'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:12,vertical:5),
                    color: Colors.grey[200],
                    child:Text('${product.cuantity??0}'),
                  ),
                  GestureDetector(
                    onTap: (){
                      _con.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:12,vertical:5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8))
                      ),
                      child: Text('+'),
                    ),
                  ),

                ]
              );
  }
  Widget _buttonNext(){
    return Container(margin: EdgeInsets.only(left: 30, right: 30, top: 20,bottom: 30),
      child: ElevatedButton(
        onPressed:_con.goToAdress,
        style: ElevatedButton.styleFrom(
          primary: MyColors.primary,
          padding: EdgeInsets.symmetric(vertical: 5)
        ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height:50,
              alignment: Alignment.center,
              child: Text('Continuar',        
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
              margin: EdgeInsets.only(right:20),
              height:50,
              alignment: Alignment.centerLeft,
              child: Icon(Icons.check,
              color: Colors.green,
              size: 30,
              ),
            ),
            )
        ],
      )
      )
    );
  }

  void refresh() {
    setState(() {});
  }
}
