import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/api/enviroment.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:http/http.dart' as http;


class CategoriesProvider{
  String _url = Environment.API_MyHOOD;
  String _api ='/api/categories';

  BuildContext context;
  
  Future init(BuildContext context) async {
    this.context = context;
  }
  Future <List<Categori>> getAll() async{
    try{
      Uri url = Uri.http(_url, '$_api/getAll');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print('Antes del decode,body de la respuesta');
      print(res.body);
      print('///////////////////////////');
      final data = json.decode(res.body);
      print('///////////////////////////');
      print('Despues del decode,printeando data desde el decode');
      print(data);
      Categori categori = Categori.fromJsonList(data);
      print(categori.toList);
      return categori.toList;
 
    }catch(e){

      print(e);
      print(e.stackTrace);
      return [];
    }
  }
  Future<ResponseApi> create(Categori category) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = jsonEncode(category);
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