import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:myhood/src/api/enviroment.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:myhood/src/models/order.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/orders_provider.dart';
import 'package:myhood/src/utils/my_snackbar.dart';
import 'package:myhood/src/utils/shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';

/// Esta clase muestra el mapa de la orden y la distancia en la que se encuentra el delivery.


class ClientOrdersMapController {

  BuildContext context;
  Function refresh;
  Position _position;

  String addressName;
  LatLng addresLatLng;

  BitmapDescriptor deliveryMarker;
  BitmapDescriptor homeMarker;
  Map<MarkerId, Marker> markers =<MarkerId, Marker> {};

  StreamSubscription _positionStream;

  User user ;
  Order order = new Order();

  OrdersProvider _ordersProvider = OrdersProvider();
  SharedPref sharedPref = SharedPref();

  double _distanceBetween;
  IO.Socket socket;



  CameraPosition initialPosition = CameraPosition(
    target: LatLng(-38.5499532,-72.4452621),
    zoom: 15,
  );

  Completer<GoogleMapController> _mapController = Completer();


  Future init(BuildContext context , Function refresh)async{

    this.context = context;
    this.refresh = refresh;
    _ordersProvider.init(context);
    order =Order.fromJson(ModalRoute.of(context).settings.arguments as Map<String,dynamic>);
    user =  User.fromJson( await sharedPref.read('user'));
    deliveryMarker = await createMarkerfromAsset('assets/img/scooter_azul_100x100.png',);
    homeMarker = await createMarkerfromAsset('assets/img/home.png',);
    socket = IO.io('http://${Environment.API_MyHOOD}/orders/delivery',<String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.on('position/${order.id}', (data) {
      print(data);
       addMarker('delivery',data['lat'],data['lng'] ,'Repartidor','',deliveryMarker);
    });

    checkGPS();
    refresh();
  }
  void updateToDelivered()async{
    if(_distanceBetween <= 100){
      ResponseApi responseApi = await _ordersProvider.updateToDelivered(order);
      if(responseApi.success){
        //Fluttertoast.showToast(msg:'Orden entregada ',toastLength: Toast.LENGTH_LONG);
        Navigator.pushNamedAndRemoveUntil(context,'delivery/orders/list', (route) => false);

      }
    }else{
      MySnackbar.show(context,"Debes estar mas cerca del lugar de entrega");
    }

  }

  void isCloseToDeliveryPosition(){
    _distanceBetween = Geolocator.distanceBetween(
      _position.latitude,
      _position.longitude,
      order.address.lat,
      order.address.lng);
  }
  

  //agrega el marcador al mapa
  void addMarker(String markerId, double lat, double lng,String title, String content, BitmapDescriptor iconMarker){
    MarkerId id = MarkerId( markerId);
    Marker marker = Marker(markerId: id,icon:iconMarker, position: LatLng(lat,lng),
    infoWindow: InfoWindow(title: title, snippet: content));
    markers[id]=marker;
    refresh();
    
   
  }
  //Asigna imagen al marcador
  Future<BitmapDescriptor> createMarkerfromAsset(String  path)async{
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(configuration,path );
    return descriptor;
  }
  void call(){
    launch("tel://${order.client.phone}");
  }

  //Enviar informacion a la pantalla anterior
  
   void selectRefPoint(){

    Map<String, dynamic> data = {
      'address': addressName,
      'lat': addresLatLng.latitude,
      'lng': addresLatLng.longitude,
    };
    Navigator.pop(context, data);
    
  }
  
  //Crear el mapa con su estilo
  void onMapCreated(GoogleMapController controller){
    controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#ebe3cd"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#523735"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f1e6"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#c9b2a6"}]},{"featureType":"administrative.land_parcel","elementType":"geometry.stroke","stylers":[{"color":"#dcd2be"}]},{"featureType":"administrative.land_parcel","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#ae9e90"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#93817c"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#a5b076"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#447530"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#f5f1e6"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#fdfcf8"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#f8c967"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#e9bc62"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#e98d58"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry.stroke","stylers":[{"color":"#db8555"}]},{"featureType":"road.local","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#806b63"}]},{"featureType":"transit","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"transit.line","elementType":"labels.text.fill","stylers":[{"color":"#8f7d77"}]},{"featureType":"transit.line","elementType":"labels.text.stroke","stylers":[{"color":"#ebe3cd"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#b9d3c2"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#92998d"}]}]');
    _mapController.complete(controller);

  }

  //Obtener la posicion actual
  void updateLocation()async{

    try{
      await _determinePosition();//Obtener posicion actual
      _position = await Geolocator.getLastKnownPosition();//Lat y Long
      animateCameraToPosition(_position.latitude, _position.longitude);//Mueve la camara hasta el punto designado
      //Agrega el marcador del delivery(Moto)     
      addMarker('delivery',order.lat, order.lng,'Tu Posicion','',deliveryMarker);//Agrega el marcador
      addMarker('home',order.address.lat, order.address.lng,'Lugar de entrega','',homeMarker);
      //Determina posicion en tiempo real del repartidor
    }catch(e){
      print("Error :"+e);
    }
  } 
  void dispose(){
    socket?.disconnect();
  }

  //Animar la camara
  Future animateCameraToPosition(double lat, double long)async{

    GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      bearing: 0
    )));

  }


  //Revisar si el GPS esta activado luego llamar al metodo que actualiza la posicion
  void checkGPS()async{
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if(isLocationEnabled){
      updateLocation();
    }else{
      bool locationGPS = await location.Location().requestService();
      if(locationGPS){
        updateLocation();
      }
    }
  }

  //Cambia el nombre de las paginas en la pantalla
  Future<Null> setLocationDraggableInfo()async{
    if(initialPosition != null){
      double lat = initialPosition.target.latitude;
      double lng = initialPosition.target.longitude;

      List<Placemark>address = await placemarkFromCoordinates(lat, lng);

      if(address != null){
        if(address.length > 0){
          String direction = address[0].thoroughfare;
          String street = address[0].subThoroughfare;
          String city = address[0].locality;
          String department = address[0].administrativeArea;
          String country = address[0].country;
          addressName ='$direction #$street , $city , $department , $country';
          addresLatLng = LatLng(lat, lng);
          refresh();
      }
    }
  }
  }

  //Metodo para obtener la posicion actual, sacado directamente desde la documentacion
  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


}

