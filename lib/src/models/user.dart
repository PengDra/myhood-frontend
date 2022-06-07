

import 'dart:convert';

import 'package:myhood/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  
    String id;
    String email;
    String name;
    String lastname;
    String rut;
    String phone;
    String image;
    String password;
    String sessionToken;
    List<Rol> roles =[];


    User({
        this.id,
        this.email,
        this.name,
        this.lastname,
        this.rut,
        this.phone,
        this.image,
        this.password,
        this.sessionToken,
        this.roles
    });



    factory User.fromJson(Map<String, dynamic> json) => User(
        //Si el string es integer se convierte a string si no solo se maneja como string
        id: json["id"] is int ? json["id"].toString() : json["id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        rut: json["rut"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
        sessionToken: json["session_token"],
        roles: json ["roles"]== null ? [] : List<Rol>.from(json["roles"].map((model) => Rol.fromJson(model))??[]),
        //Si el roles es null, lo pone vacio, si no lo pone como lista desde el modelo
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "rut": rut,
        "phone": phone,
        "image": image,
        "password": password,
        "session_token": sessionToken,
        "roles": roles,
    };
}
