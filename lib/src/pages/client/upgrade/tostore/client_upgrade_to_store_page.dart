import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myhood/src/pages/client/upgrade/tostore/client_upgrade_to_store_controller.dart';
import 'package:myhood/src/pages/client/upgrade/tostore/client_upgrade_to_store_page.dart';


import 'package:myhood/src/pages/register/register_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';


class ClientUpgradeToStorePage extends StatefulWidget {
  const ClientUpgradeToStorePage({Key key}) : super(key: key);
  @override
  State<ClientUpgradeToStorePage> createState() => _ClientUpgradeToStorePageState();
}

class _ClientUpgradeToStorePageState extends State<ClientUpgradeToStorePage> {
  ClientUpgradeToStoreController _con = new ClientUpgradeToStoreController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Crear Tienda')
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),           
              _imageUser(),
              const SizedBox(height: 20),
              _textFieldName(),  
              const SizedBox(height: 20), 
              _textFieldAdress(),                                
              const SizedBox(height: 20),
              _textFieldPointRef()
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonRegister(),
    );
  }

  Widget _textRegister() {
    return Row(
      children: [
        IconButton(onPressed: _con.back, icon: const Icon(Icons.arrow_back_ios)),
        const Text(
          'ATRAS',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap:
        _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null 
                        //Si la imagen existe, la muestra en el circulo
                        ? FileImage(_con.imageFile)
                        //Si la url de la imagen existe 
                        :_con.user?.image != null
                        //muestrala desde interntet
                        ? AssetImage('assets/img/user_profile_2.png')
                        //Si no existe, muestra la imagen por defecto
                        : AssetImage('assets/img/user_profile_2.png'),
        radius: 50,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

   Widget _textFieldPointRef(){
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        controller: _con.refPointController,
        onTap: _con.openMap,
        autofocus:false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.map),
          labelText: 'Punto de referencia',
          labelStyle: TextStyle(
            color: MyColors.primary,
            fontSize: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
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
          hintText: 'Nombre',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.person, color: MyColors.primary),
        ),
      ),
    );
  }
  Widget _textFieldAdress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.addressController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Direccion',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.person, color: MyColors.primary),
        ),
      ),
    );
  }


  Widget _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton(
          onPressed: _con.isEnabled ? _con.createStore:null,
          child: Text('Crear Tienda'),
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
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
