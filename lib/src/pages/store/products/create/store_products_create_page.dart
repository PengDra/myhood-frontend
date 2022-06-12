import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/pages/store/products/create/store_products_create_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';

class StoreProductsCreatePage extends StatefulWidget {
  const StoreProductsCreatePage({Key key}) : super(key: key);

  @override
  State<StoreProductsCreatePage> createState() =>
      _StoreProductsCreatePageState();
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
      body: ListView(children: [
        const SizedBox(height: 50),
        _textFieldName(),
        const SizedBox(height: 20),
        _textFieldDescription(),
        const SizedBox(height: 20),
        _textFieldPrice(),
        Container(
          height: 80,
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _cardImage(null, 1),
              _cardImage(null, 2),
              _cardImage(null, 3)
            ],
          ),
        ),
        _dropdownCategory(_con.categories)
      ]),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _dropdownCategory(List<Categori> categories) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [
            Row(
              children: [
                Icon(
                  Icons.search,
                  color: MyColors.primary,
                  size: 30,
                ),
                Text(
                  'Categoría',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                  'Selecciona una categoría',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                items: _dropDownItems(categories),
                value: _con.idCategory,
                onChanged: (option){
                  setState(() {
                    _con.idCategory = option;
                  });
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>>_dropDownItems(List<Categori>categories){
    List<DropdownMenuItem<String>> list =[];

    categories.forEach((category) {
      
      list.add(DropdownMenuItem(
        child: Text(category.name),
        value: category.id,
      ));
    });
    return list;

  }

  Widget _textFieldName() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        maxLines: 2,
        maxLength: 180,
        controller: _con.nameController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Nombre del Producto',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(Icons.breakfast_dining, color: MyColors.primary),
        ),
      ),
    );
  }

  Widget _cardImage(File imageFile, int numberfile) {
    return imageFile != null
        ? Card(
            elevation: 3.0,
            child: Container(
              height: 140,
              width: MediaQuery.of(context).size.width * 0.26,
              child: Image.file(imageFile, fit: BoxFit.cover),
            ))
        : Card(
            elevation: 3.0,
            child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image(image: AssetImage('assets/img/add_image.png'))));
  }

  Widget _textFieldPrice() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        maxLines: 1,
        keyboardType: TextInputType.phone,
        controller: _con.priceController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Precio',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(Icons.monetization_on, color: MyColors.primary),
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
