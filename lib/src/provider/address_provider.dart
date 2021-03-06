import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/api/enviroment.dart';
import 'package:myhood/src/models/address.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:http/http.dart' as http;


/// Esta es la clase que interactua con el API para crear y obtener las direcciones.


class AddressProvider{
  String _url = Environment.API_MyHOOD;
  String _api ='/api/address';

  BuildContext context;
  
  Future init(BuildContext context) async {
    this.context = context;
  }
  ///Este metodo recibe el [String idUser] y devuelve una lista de [Address] dependiendo del id del usuario.
  Future <List<Address>> getByUser(String idUser) async{
    try{
      Uri url = Uri.http(_url, '$_api/findByUser/$idUser');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print('Antes del decode,body de la respuesta');
      print(res.body);
      print('///////////////////////////');
      final data = json.decode(res.body);
      print('///////////////////////////');
      print('Despues del decode,printeando data desde el decode');
      print(data);
      Address categori = Address.fromJsonList(data);
      print(categori.toList);
      return categori.toList;
 
    }catch(e){

      print(e);
      print(e.stackTrace);
      return [];
    }
  }


  /// Este metodo recibe un [Address] y lo guarda en el API.
  Future<ResponseApi> create(Address address) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = jsonEncode(address);
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