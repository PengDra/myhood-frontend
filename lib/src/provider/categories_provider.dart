import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/api/enviroment.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:http/http.dart' as http;
import 'package:myhood/src/models/store.dart';


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
  Future <List<Categori>> getByIdStore(String idStore) async{
    try{
      Uri url = Uri.http(_url, '$_api/getByIdStore/$idStore');
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
  Future<ResponseApi> create(Categori category, Store store) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String jsonCategory = jsonEncode(category);
      String jsonStore = jsonEncode(store);
      
      Map<String, String> headers = {'Content-Type': 'application/json'};
      //final res = await http.post(url, headers: headers, body: jsonCategory, jsonStore);
      //create the response object adding jsonCategory and jsonStore to the body
      final res = await http.post(url, headers: headers, body: jsonEncode(
        {
          'category': jsonCategory,
          'store': jsonStore
        }
      ));

      //final res = await http.post(url, headers: headers, body:'{"category":['+ jsonCategory + '],' +'"store":['+ jsonStore+']}');
      //final res = await http.post(url, headers: headers, body: jsonCategory+jsonStore);
      
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Exception create: $e');
      return null;
    }
  }
  /*
  Future<Stream>createWithStore(Store store ,Categori categori)async{
    try{
      print(categori.toString());
       //Se genera la url desde la cual se va a consumir el servicio
      Uri url = Uri.http(_url, '$_api/create');
      //Se crea el mapa con los datos que se van a enviar(Request Multipart)
      //final request = http.MultipartRequest('POST', url);
      final request = http.Request('POST', url);
      
      //Se agrega el body del request
      request.fields['store']=json.encode(store);
      request.fields['category']=json.encode(categori);
      //Se envia el request al servicio
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
      
    }catch(e){
      print('Error: '+e);
      return null;
    }
  }
  */




}