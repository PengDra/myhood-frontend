import 'dart:convert';
import 'dart:io';
import 'package:myhood/src/models/store.dart';
import 'package:path/path.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myhood/src/api/enviroment.dart';
import 'package:myhood/src/models/categori.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
/// Esta es la clase que interactua con el API para crear y obtener los productos.

class ProductsProvider{
  String _url = Environment.API_MyHOOD;
  String _api ='/api/products';

  BuildContext context;
  
  Future init(BuildContext context) async {
    this.context = context;
  }

  ///Este metodo recibe como parametro un [Store], un [Product] y un [List<File>] que corresponden a la lista de imagenes del producto.
  ///Debido a que se envian multiples imagenes, se utiliza el metodo [multipartRequest] para enviar las imagenes al API.
  ///por lo tanto la respuesta de este metodo es un objeto de tipo Stream que viene del paquete [http].
  ///este objeto se convierte en una lista de tipo StreamedResponse  y se devuelve decodificado.
  
  Future<Stream>create(Store store ,Product product,List<File> images)async{
    try{
      print(product.toString());
       //Se genera la url desde la cual se va a consumir el servicio
      Uri url = Uri.http(_url, '$_api/create');
      //Se crea el mapa con los datos que se van a enviar(Request Multipart)
      final request = http.MultipartRequest('POST', url);
      //Si el la imagen no es nula se agrega al request
      for(int i = 0; i < images.length; i++){
        request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(images[i].openRead().cast()),
          await images[i].length(),
          filename: basename(images[i].path),
        ));
      }
      
      //Se agrega el body del request
      request.fields['store']=json.encode(store);
      request.fields['product']=json.encode(product);
      //Se envia el request al servicio
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
      
    }catch(e){
      print('Error: '+e);
      return null;
    }
  }

  /// Este metodo recibe como parametro un [String] que corresponde al id del producto.
  /// Se devuelve un objeto de tipo [Product] que corresponde al producto que se busca.
   Future <List<Product>> getByCategory(String idCategory) async{
    try{
      Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print('Antes del decode,body de la respuesta');
      print(res.body);
      print('///////////////////////////');
      final data = json.decode(res.body);
      print('///////////////////////////');
      print('Despues del decode,printeando data desde el decode');
      print(data);
      Product product = Product.fromJsonList(data);
      print(product.toList);
      return product.toList;
 
    }catch(e){

      print(e);
      print(e.stackTrace);
      return [];
    }
  }



}