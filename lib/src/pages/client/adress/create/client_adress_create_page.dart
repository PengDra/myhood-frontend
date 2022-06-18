import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myhood/src/pages/client/adress/create/client_adress_create_controller.dart';
import 'package:myhood/src/pages/client/adress/list/client_adress_list_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';

class ClientAdressCreatePage extends StatefulWidget {
  const ClientAdressCreatePage({Key key}) : super(key: key);

  @override
  State<ClientAdressCreatePage> createState() => _ClientAdressCreatePageState();
}

class _ClientAdressCreatePageState extends State<ClientAdressCreatePage> {
   ClientAdressCreateController _con = ClientAdressCreateController();

  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Direcciones'),
        backgroundColor: MyColors.primary,
        elevation: 0,
      ),
      body: Column(
        children:[
          _textCompleteData(),
          _textFieldAdress(),
          _textFieldNeighborhood(),
          _textFieldPointRef()


        ],
      ),
      bottomNavigationBar: _buttonAccept(),
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


  Widget _textFieldNeighborhood(){
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.location_city),       
          labelText: 'Vecindario',
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


  Widget _textFieldAdress(){
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.location_on),
          labelText: 'Direccion',
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

   Widget _textCompleteData(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal:40,vertical:30),
      child: Text('Completa Estos Datos'
      ,style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }


   Widget _buttonAccept(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: ElevatedButton(
        child: Text('Crear Direccion', style: TextStyle(color: Colors.white),),
        onPressed: (){
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          primary: MyColors.primary
        )
      ),
    );
  }
  
  void refresh(){
    setState(() {});
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}