import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';



class ClientProductsDetailPage extends StatefulWidget {

  Product product;

  ClientProductsDetailPage({Key key,@required this.product}) : super(key: key);

  @override
  State<ClientProductsDetailPage> createState() => _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {
  
  ClientProductsDetailController _con = ClientProductsDetailController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp){
      _con.init(context, refresh , widget.product);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.9,
      child: Column(
        children: [
          _imageSlideShow()
        ],
      ),
    );
    
    
  }
  Widget _imageSlideShow(){
    return  ImageSlideshow(
          width: double.infinity,
          height:MediaQuery.of(context).size.height*0.4,
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
                    fit: BoxFit.contain,
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
             FadeInImage(
                    image: _con.product?.image2 != null
                        ? NetworkImage(_con.product.image2)
                        : AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.contain,
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
             FadeInImage(
                    image: _con.product?.image3 != null
                        ? NetworkImage(_con.product.image3)
                        : AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.contain,
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
          ],
        );
  }
  void refresh(){
    setState(() {});
  }
}