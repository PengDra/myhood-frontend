import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myhood/src/pages/client/upgrade/todelivery/client_upgrade_to_delivery_controller.dart';

import 'package:myhood/src/utils/my_colors.dart';


class ClientUpgradeToDeliveryPage extends StatefulWidget {
  const  ClientUpgradeToDeliveryPage({Key key}) : super(key: key);
  @override
  State<ClientUpgradeToDeliveryPage> createState() => _ClientUpgradeToDeliveryState();
}

class _ClientUpgradeToDeliveryState extends State<ClientUpgradeToDeliveryPage> {
   ClientUpgradeToDeliveryController _con = new  ClientUpgradeToDeliveryController();

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
        title:Text('Editar Perfil')
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
              _textFieldLastName(),
              const SizedBox(height: 20),
              _textFieldPhone(),
              const SizedBox(height: 20),
              
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
                        ? NetworkImage(_con.user.image)
                        //Si no existe, muestra la imagen por defecto
                        : AssetImage('assets/img/user_profile_2.png'),
        radius: 50,
        backgroundColor: Colors.grey[200],
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

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.lastNameController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Apellido',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.person_outline, color: MyColors.primary),
        ),
      ),
    );
  }

  

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: _con.phoneController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Telefono',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.phone, color: MyColors.primary),
        ),
      ),
    );
  }


  Widget _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton(
          onPressed: _con.isEnabled ? _con.update:null,
          child: Text('Actualizar Datos'),
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
