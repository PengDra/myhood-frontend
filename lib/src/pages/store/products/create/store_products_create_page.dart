import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myhood/src/pages/store/products/create/store_products_create_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';



class StoreProductsCreatePage extends StatefulWidget {
  const StoreProductsCreatePage({Key key}) : super(key: key);

  @override
  State<StoreProductsCreatePage> createState() => _StoreProductsCreatePageState();
}

class _StoreProductsCreatePageState extends State<StoreProductsCreatePage> {
   StoreProductsCreateController _con = new StoreProductsCreateController();
  
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
        title: Text('Nuevo Producto'),
      ),
      body: Column(
        children:[
          const SizedBox(height: 50),
          _textFieldName(),
          const SizedBox(height: 20),
          _textFieldDescription(),


        ] 
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }
  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(  
        controller: _con.nameController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Nombre del Producto',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(Icons.list_alt, color: MyColors.primary),
        ),
      ),
    );
  }
  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(  
        maxLines: 3,
        maxLength: 255,
        controller: _con.descriptionController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Descripcion de Categoria',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(Icons.list_alt, color: MyColors.primary),
        ),
      ),
    );
  }
   Widget _buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton(
          onPressed: _con.createProduct,
          child: Text('Crear Producto'),
          style: ElevatedButton.styleFrom(
              primary: MyColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 15))),
    );
}
  void refresh() {
    setState(() {});
  }
}