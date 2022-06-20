import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myhood/src/api/enviroment.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:http/http.dart' as http;
import '../models/order.dart';


class OrdersProvider{
  String _url = Environment.API_MyHOOD;
  String _api ='/api/orders';

  BuildContext context;
  
  Future init(BuildContext context) async {
    this.context = context;
  }

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