import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/pages/client/adress/list/client_adress_list_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';
import 'package:myhood/src/widgets/no_data_widget.dart';


class ClientAdressListPage extends StatefulWidget {
  const ClientAdressListPage({Key key}) : super(key: key);

  @override
  State<ClientAdressListPage> createState() => _ClientAdressListPageState();
}

class _ClientAdressListPageState extends State<ClientAdressListPage> {

  ClientAdressListController _con = ClientAdressListController();

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
        actions: [
          _iconAdd()
        ],
      ),
      body:Container(
        width: double.infinity,
        child: Column(
          children: [
            _textSelectAdress(),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: NoDataWidget(text:'Agrega una nueva direccion')),
            _buttonNewAdress()
          ],
        ),
      ),
      bottomNavigationBar: _buttonAccept(),
    );
    
  }
  Widget _buttonNewAdress(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: ElevatedButton(
        child: Text('Nueva Direccion', style: TextStyle(color: Colors.white),),
        onPressed: _con.goToNewAdress,
        style: ElevatedButton.styleFrom(
          primary: MyColors.primary
        )
      ),
    );
  }
  Widget _buttonAccept(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: ElevatedButton(
        child: Text('Aceptar', style: TextStyle(color: Colors.white),),
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
  Widget _textSelectAdress(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal:40,vertical:30),
      child: Text('Seleccione una direccion'
      ,style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
  Widget _iconAdd(){
    return IconButton(
      icon: Icon(Icons.add),
      onPressed:_con.goToNewAdress,
    );

  }
  void refresh(){
    setState(() {});
  }
}