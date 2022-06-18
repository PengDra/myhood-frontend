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





}