import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myhood/src/pages/client/adress/list/client_adress_list_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';

class ClientAdressCreatePage extends StatefulWidget {
  const ClientAdressCreatePage({Key key}) : super(key: key);

  @override
  State<ClientAdressCreatePage> createState() => _ClientAdressCreatePageState();
}

class _ClientAdressCreatePageState extends State<ClientAdressCreatePage> {
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
      ),
      body: Center(
        child: Text('Mi Direcciones'),
      ),
    );
    
  }
  void refresh(){
    setState(() {});
  }
}