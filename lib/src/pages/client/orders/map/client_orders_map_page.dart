import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myhood/src/pages/client/adress/list/client_adress_list_controller.dart';
import 'package:myhood/src/pages/client/adress/map/client_adress_map_controller.dart';
import 'package:myhood/src/pages/delivery/orders/map/delivery_orders_map_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';
import 'package:myhood/src/widgets/no_data_widget.dart';

class ClientOrdersMapPage extends StatefulWidget {
  const ClientOrdersMapPage({Key key}) : super(key: key);

  @override
  State<ClientOrdersMapPage> createState() => _ClientOrdersMapPageState();
}

class _ClientOrdersMapPageState extends State<ClientOrdersMapPage> {
  DeliveryOrdersMapController _con = DeliveryOrdersMapController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }
  @override
  void dispose() {
    _con.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SafeArea(
          child: Column(
            children: [
              _buttonCenterPosition(),
              Spacer(),
              _cardInfoOrder(),
             
            ],
          ),
        ),
        
        
        Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: _googleMaps()),
        
       
       
      ]),
    );
  }
 
  
  Widget _cardInfoOrder() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            _listTileAddress(
                _con.order?.address?.neighborhood, 'Barrio', Icons.my_location),
            _listTileAddress(
                _con.order?.address?.address, 'Direccion', Icons.location_on),
            Divider(color: Colors.grey),
            _clientInfo(),
            
          ],
        ));
  }

  Widget _clientInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: FadeInImage(
              image: _con.order?.delivery?.image != null
                  ? NetworkImage(_con.order?.delivery?.image)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              '${_con.order?.delivery?.name} ${_con.order?.delivery.lastname}' ?? '',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: MyColors.primary),
            child: IconButton(
              icon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              onPressed: () {
                _con.call();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTileAddress(String title, String subtitle, IconData iconData) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 10),
          ),
          trailing: Icon(iconData),
        ));
  }

  Widget _buttonCenterPosition() {
    return GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.centerRight,
          child: Card(
            shape: CircleBorder(),
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.location_searching,
                color: MyColors.primary,
                size: 30,
              ),
            ),
          ),
        ));
  }

  Widget _googleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),
    );
  }
  

  void refresh() {
    if(!mounted) return;
    setState(() {});
  }
}
