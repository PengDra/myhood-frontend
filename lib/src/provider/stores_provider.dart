import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/api/enviroment.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:http/http.dart' as http;

import '../models/store.dart';
import '../models/user.dart';
/// Esta es la clase que interactua con el API para crear y obtener las categorias.
/// 

class StoresProvider{
  String _url = Environment.API_MyHOOD;
  String _api ='/api/stores';

  BuildContext context;
  
  Future init(BuildContext context) async {
    this.context = context;
  }
  ///Este metodo recibe como parametro el [Store], [User] , una imagen y crea una tienda.
  ///Devuelve un objeto de Tipo Stream StreamedResponse.
  Future<Stream>create(Store store,User user,File image)async{
    try{
      print(store.toString());
       //Se genera la url desde la cual se va a consumir el servicio
      Uri url = Uri.http(_url, '$_api/create');
      //Se crea el mapa con los datos que se van a enviar(Request Multipart)
      final request = http.MultipartRequest('POST', url);
      //Si el la imagen no es nula se agrega al request
      if(image!=null){
        request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(image.openRead().cast()),
          await image.length(),
          filename: basename(image.path),
        ));
      }
      
      //Se agrega el body del request
      request.fields['store']=json.encode(store);
      request.fields['user']=json.encode(user);
      //Se envia el request al servicio
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
      
    }catch(e){
      print('Error: '+e);
      return null;
    }
  }

  /// Este metodo recibe como parametro el String del id del [User] y devuelve un objeto de tipo [Store].
  Future<Store> getStoreByUserId(String id) async {
    try{
      Uri url = Uri.http(_url, '$_api/findByUserId/$id');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print(res);
      final data = json.decode(res.body);
      Store store = Store.fromJson(data);
      print(store.toJson());
      return store;
    }catch(e){
      print(e);
      return null;
    }
  }
  ///Este metodo recibe todas las tiendas
  
  Future<List<Store>> getAll() async {
    try{
      Uri url = Uri.http(_url, '$_api/findAll');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print(res);
      final data = json.decode(res.body);
      List<Store> stores = new List<Store>();
      data.forEach((element) {
        stores.add(Store.fromJson(element));
      });
      return stores;
    }catch(e){
      print(e);
      return null;
    }
  }
  



}