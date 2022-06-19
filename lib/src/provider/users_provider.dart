import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myhood/src/api/enviroment.dart';
import 'package:myhood/src/models/response_api.dart';
import 'package:myhood/src/models/user.dart';
import 'package:path/path.dart';

class UsersProvider {

  String _url = Environment.API_MyHOOD;
  String _api = '/api/users';
  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }
  Future<User> getById(String id) async {
    try{
      Uri url = Uri.http(_url, '$_api/findById/$id');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print(res.body);
      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    }catch(e){
      print(e);
      return null;
    }
    
    
  }
  Future<List<User>> getDeliveryMan() async {
    try{
      Uri url = Uri.http(_url, '$_api/findDeliveryMan');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(url, headers: headers);
      print(res.body);
      final data = json.decode(res.body);
      User user = User.fromJsonList(data);
      return user.toList;
    }catch(e){
      print(e);
      return null;
    }
    
    
  }
  Future<Stream>createWithImage(User user,File image)async{
    try{
      print(user.toString());
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
      request.fields['user']=json.encode(user);
      //Se envia el request al servicio
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
      
    }catch(e){
      print('Error: '+e);
      return null;
    }

  }
  Future<Stream>update(User user,File image)async{
    try{
      //Se genera la url desde la cual se va a consumir el servicio
      Uri url = Uri.http(_url, '$_api/update');
      //Se crea el mapa con los datos que se van a enviar(Request Multipart)
      final request = http.MultipartRequest('PUT', url);
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
      request.fields['user']=json.encode(user);
      //Se envia el request al servicio
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
      
    }catch(e){
      print('Error: '+e);
      return null;
    }

  }

  Future<ResponseApi> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = jsonEncode(user);
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
  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = jsonEncode({
        'email': email,
        'password': password
      });
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      print(responseApi);
      return responseApi;
    } catch (e) {
      print('Exception login: $e');
      return null;
    }
  }
}
