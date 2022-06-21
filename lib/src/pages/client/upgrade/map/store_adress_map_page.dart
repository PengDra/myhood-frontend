import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:myhood/src/pages/client/adress/map/client_adress_map_controller.dart';
import 'package:myhood/src/pages/client/upgrade/map/store_adress_map_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';
import 'package:myhood/src/widgets/no_data_widget.dart';


class StoreAdressMapPage extends StatefulWidget {
  const StoreAdressMapPage({Key key}) : super(key: key);

  @override
  State<StoreAdressMapPage> createState() => _StoreAdressMapPageState();
}

class _StoreAdressMapPageState extends State<StoreAdressMapPage> {

  StoreAdressMapController _con =StoreAdressMapController();

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
        title: Text('Ingresa tu ubicacion en el mapa'),
        backgroundColor: MyColors.primary,
        
      ),
      body: Stack(
        children:[
          _googleMaps(),
          Container(
            alignment: Alignment.center,
            child:
                  _iconMyLocation(),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.topCenter,
            child: _cardAdress(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: _buttonSelect(),
          )
        ]
        
      ),
      
    );
    
  }
  Widget _iconMyLocation(){
    return Image.asset(
      'assets/img/my_location.png',
      width: 50,
      height: 50,

    );
  }
  Widget _buttonSelect(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30,horizontal: 70),
      child: ElevatedButton(
        child: Text('Seleccionar este Punto', style: TextStyle(color: Colors.white),),
        onPressed: _con.selectRefPoint,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          primary: MyColors.primary
        )
      ),
    );
  }
  Widget _cardAdress(){
    return Container(
      
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child:
         Container(
          padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
          child: Text(
            _con.addressName ??'',
            style:TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold))),)
    );
  }


  Widget _googleMaps(){
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _con.initialPosition,
        onMapCreated: _con.onMapCreated,
        myLocationEnabled:false,
        myLocationButtonEnabled:false,
        onCameraMove: (position){
          _con.initialPosition =position;
        },
        onCameraIdle: () async{
          await _con.setLocationDraggableInfo();
        }
      );
  }
 

  
  void refresh(){
    setState(() {});
  }
}