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


class DeliveryOrdersMapPage extends StatefulWidget {
  const DeliveryOrdersMapPage({Key key}) : super(key: key);

  @override
  State<DeliveryOrdersMapPage> createState() => _DeliveryOrdersMapPageState();
}

class _DeliveryOrdersMapPageState extends State<DeliveryOrdersMapPage> {

  DeliveryOrdersMapController _con =  DeliveryOrdersMapController();

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
     
      body: Stack(
        children:[
          _googleMaps(),
          
          
          Container(
            alignment: Alignment.bottomCenter,
            child: _buttonSelect(),
          )
        ]
        
      ),
      
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
 


  Widget _googleMaps(){
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _con.initialPosition,
        onMapCreated: _con.onMapCreated,
        myLocationEnabled:false,
        myLocationButtonEnabled:false,
        markers: Set<Marker>.of(_con.markers.values),
        

      );
  }
 

  
  void refresh(){
    setState(() {});
  }
}