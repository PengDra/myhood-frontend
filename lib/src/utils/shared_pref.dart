import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  //Guardar elemento en el dispositivo
  void save(String key, value)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }
  //leer elemento en el dispositivo
  Future<dynamic> read(String key)async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString(key) == null)return null;
    
    return json.decode(prefs.getString(key));
  }
  //Saber si existe algo en el shared preferences
  Future<bool> exist(String key)async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
  //Eliminar elemento en el dispositivo
  Future<bool>remove(String key)async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
  //Logout de la aplicacion
  void logout(BuildContext context )async{
    await remove('user');
    Navigator.pushNamedAndRemoveUntil(context,'login', (route) => false);
  }
}