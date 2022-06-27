import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myhood/src/api/enviroment.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:http/http.dart' as http;
import 'package:myhood/src/models/store.dart';
import '../models/order.dart';

/// Esta es la clase que interactua con el API para crear y obtener las ordenes.

class OrdersProvider{
  String _url = Environment.API_MyHOOD;
  String _api ='/api/orders';

  BuildContext context;
  
  Future init(BuildContext context) async {
    this.context = context;
  }

  /// Este metodo crea una order en el API.
  /// Devuelve una [ResponseApi] con el estado de la respuesta.

  Future<ResponseApi> create(Order order) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = jsonEncode(order);
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Exception create: $e');
      return null;
    }
  }

  Future<ResponseApi> createWithStore(Order order,Store store) async {
    try {
      Uri url = Uri.http(_url, '$_api/createWithStore');
      String jsonOrder= jsonEncode(order);
      String jsonStore= jsonEncode(store);
      
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.post(url, headers: headers, body: jsonEncode({
        'order': jsonOrder,
        'store': jsonStore
      }));
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Exception create: $e');
      return null;
    }
  }

  /// Este metodo recibe una orden y actualiza el estado a "DESPACHADO" en el API.
  /// Devuelve una [ResponseApi] con el estado de la respuesta.
  Future<ResponseApi> updateToDispatched(Order order) async {
    try {
      Uri url = Uri.http(_url, '$_api/updateToDispatched');
      String bodyParams = jsonEncode(order);
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.put(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Exception create: $e');
      return null;
    }
  }
  /// Este metodo recibe una orden y actualiza el estado a "EN CAMINO" en el API.
  /// Devuelve una [ResponseApi] con el estado de la respuesta.
  Future<ResponseApi> updateToOnTheWay(Order order) async {
    try {
      Uri url = Uri.http(_url, '$_api/updateToOnTheWay');
      String bodyParams = jsonEncode(order);
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.put(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Exception create: $e');
      return null;
    }
  }
  /// Este metodo recibe una orden y actualiza el estado a "ENTREGADO" en el API.
  /// Devuelve una [ResponseApi] con el estado de la respuesta.
   Future<ResponseApi> updateToDelivered(Order order) async {
    try {
      Uri url = Uri.http(_url, '$_api/updateToDelivered');
      String bodyParams = jsonEncode(order);
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.put(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Exception create: $e');
      return null;
    }
  }
  /// Este metodo se encarga de obtener todas las ordenes del API separadas por id de tienda y Estado
  /// Devuelve una lista de [Order] con las ordenes.
  
  Future <List<Order>> getByStoreAndStatus(String idStore,String status) async{
    try{
      Uri url = Uri.http(_url, '$_api/findByStoreAndStatus/$idStore/$status');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print('Antes del decode,body de la respuesta');
      print(res.body);
      print('///////////////////////////');
      final data = json.decode(res.body);
      print('///////////////////////////');
      print('Despues del decode,printeando data desde el decode');
      print(data);
      Order order = Order.fromJsonList(data);
      print(order.toList);
      return order.toList;
 
    }catch(e){

      print(e);
      print(e.stackTrace);
      return [];
    }
  }

  /// Esta consulta se encarga de obtener todas las ordenes del API separadas por estado.
  /// Devuelve una lista de [Order] con las ordenes.
  Future <List<Order>> getByDeliveryAndStatus(String idDelivery,String status) async{
    try{
      Uri url = Uri.http(_url, '$_api/findByDeliveryAndStatus/$idDelivery/$status');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print('Antes del decode,body de la respuesta');
      print(res.body);
      print('///////////////////////////');
      final data = json.decode(res.body);
      print('///////////////////////////');
      print('Despues del decode,printeando data desde el decode');
      print(data);
      Order order = Order.fromJsonList(data);
      print(order.toList);
      return order.toList;
 
    }catch(e){

      print(e);
      print(e.stackTrace);
      return [];
    }
  }
  /// Esta consulta obtiene todas las ordenes de cliente
  /// Devuelve una lista de [Order] con las ordenes.

  Future <List<Order>> getByClientAndStatus(String idClient,String status) async{
    try{
      Uri url = Uri.http(_url, '$_api/findByClientAndStatus/$idClient/$status');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print('Antes del decode,body de la respuesta');
      print(res.body);
      print('///////////////////////////');
      final data = json.decode(res.body);
      print('///////////////////////////');
      print('Despues del decode,printeando data desde el decode');
      print(data);
      Order order = Order.fromJsonList(data);
      print(order.toList);
      return order.toList;
 
    }catch(e){

      print(e);
      print(e.stackTrace);
      return [];
    }
  }


  /// Esta consulta obtiene todas las ordenes por estado
  /// Devuelve una lista de [Order] con las ordenes.
  Future <List<Order>> getByStatus(String status) async{
    try{
      Uri url = Uri.http(_url, '$_api/findByStatus/$status');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print('Antes del decode,body de la respuesta');
      print(res.body);
      print('///////////////////////////');
      final data = json.decode(res.body);
      print('///////////////////////////');
      print('Despues del decode,printeando data desde el decode');
      print(data);
      Order order = Order.fromJsonList(data);
      print(order.toList);
      return order.toList;
 
    }catch(e){

      print(e);
      print(e.stackTrace);
      return [];
    }
  }





}