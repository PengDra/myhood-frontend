import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';

class ClientProductsDetailPage extends StatefulWidget {
  Product product;

  ClientProductsDetailPage({Key key, @required this.product}) : super(key: key);

  @override
  State<ClientProductsDetailPage> createState() =>
      _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {
  ClientProductsDetailController _con = ClientProductsDetailController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          _imageSlideShow(),
          _textName(),
          _textDescription(),
          Spacer(),
          _addOrRemoveItem(),
          _standardDelivery(),
          _buttonShoppingBag()  
        ],
      ),
    );
  }

  Widget _textName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right:30, left: 30, top: 30),
      child: Text(
      _con.product?.name ?? '',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: MyColors.black,
      ),
    ));
  }
  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right:30, left: 30, top: 15),
      child: Text(
      _con.product?.description ?? '',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    ));
  }
  Widget _addOrRemoveItem(){
    return Container(
      margin:EdgeInsets.symmetric(horizontal:18),
      child: Row(
        children:[
        IconButton(
          icon: Icon(Icons.add_circle_outline,
          color: Colors.grey,
          size: 30,
          ),
          onPressed: _con.addItem,
        ),
        Text('${_con.counter}',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        ),
        IconButton(
          icon: Icon(Icons.remove_circle_outline,
          color: Colors.grey,
          size: 30,
          ),
          onPressed: _con.removeItem,
        ),
        Spacer(),
        Container(
          child:Text('${_con.productPrice ?? 0.0}',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          ),
          ),
        
        ]
      ),
    );
    
  }

  Widget _imageSlideShow() {
    return Stack(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          initialPage: 0,
          indicatorColor: MyColors.primary,
          indicatorBackgroundColor: Colors.grey,
          onPageChanged: (value) {
            debugPrint('Page changed: $value');
          },
          autoPlayInterval: 7000,
          isLoop: true,
          children: [
            FadeInImage(
              image: _con.product?.image1 != null
                  ? NetworkImage(_con.product.image1)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
            FadeInImage(
              image: _con.product?.image2 != null
                  ? NetworkImage(_con.product.image2)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
            FadeInImage(
              image: _con.product?.image3 != null
                  ? NetworkImage(_con.product.image3)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ],
        ),
        Positioned(
          left: 10,
          top: 5,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios,
            color: MyColors.primary,
            size: 30,
            ),
            onPressed: _con.close,
          ),
          ),
      ],
    );
  }
  Widget _standardDelivery(){
    return Container(
      margin:EdgeInsets.symmetric(horizontal:30),
      child: Row(
        children:[
          Image.asset('assets/img/scooter_azul.png',
          height:17),
          SizedBox(width: 7),
          Text('Entrega Estandar',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),         
          )
        ]
      )
    );
  }
  Widget _buttonShoppingBag(){
    return Container(margin: EdgeInsets.only(left: 30, right: 30, top: 20,bottom: 30),
      child: ElevatedButton(
        onPressed:_con.addToBag,
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
              child: Text('Agregar a la Bolsa',        
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
              child: Icon(Icons.shopping_cart,
              color: Colors.white,
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
