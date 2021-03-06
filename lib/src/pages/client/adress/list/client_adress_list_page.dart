import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/models/address.dart';
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
        title: Text('Mis Direcciones'),
        backgroundColor: MyColors.primary,
        elevation: 0,
        actions: [_iconAdd()],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: _textSelectAdress(),
          ),
          
          Container(
            margin: EdgeInsets.only(top: 50),
            child: _listAddress()),
        ],
      ),
      bottomNavigationBar: _buttonAccept(),
    );
  }

  Widget _noAddress() {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(top: 30),
          child: NoDataWidget(text: 'Agrega una nueva direccion')),
      _buttonNewAdress()
    ]);
  }

  Widget _radioSelectorAddress(Address address, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(children: [
            Radio(
              value: index,
              groupValue: _con.radioValue,
              onChanged: _con.handleRadioValueChange,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address?.address ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  address?.neighborhood ?? '',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),   
          ]),
           Divider(
              color: Colors.grey,
            )
        ],
      ),
    );
  }

  Widget _listAddress() {
    return FutureBuilder(
        future: _con.getAdress(),
        builder: (context, AsyncSnapshot<List<Address>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    return _radioSelectorAddress(snapshot.data[index], index);
                  });
            } else {
              return _noAddress();
            }
          } else {
            return _noAddress();
          }
        });
  }

  Widget _buttonNewAdress() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
          child: Text(
            'Nueva Direccion',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: _con.goToNewAdress,
          style: ElevatedButton.styleFrom(primary: MyColors.primary)),
    );
  }

  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
          child: Text(
            'Aceptar',
            style: TextStyle(color: Colors.white),
          ),
          onPressed:_con.createOrder,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              primary: MyColors.primary)),
    );
  }

  Widget _textSelectAdress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Seleccione una direccion',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _iconAdd() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: _con.goToNewAdress,
    );
  }

  void refresh() {
    setState(() {});
  }
}
