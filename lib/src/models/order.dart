import 'dart:convert';

import 'package:myhood/src/models/address.dart';
import 'package:myhood/src/models/product.dart';
import 'package:myhood/src/models/user.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {

    String id;
    String idClient;
    String idDelivery;
    String idAddress;
    String status;
    double lat;
    double lng;
    int timestamp;
    List<Product> products = [];
    List<Order> toList = [];
    User client= new User();
    Address address= new Address();
    


    Order({
        this.id,
        this.idClient,
        this.idDelivery,
        this.idAddress,
        this.status,
        this.lat,
        this.lng,
        this.timestamp,
        this.products,
        this.client,
        this.address,
    });

    

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        idClient: json["id_client"],
        idDelivery: json["id_delivery"],
        idAddress: json["id_address"],
        status: json["status"],
        lat: json["lat"] is String ? double.parse(json["lat"]) : json["lat"],
        lng: json["lng"]is String ? double.parse(json["lng"]) : json["lng"],
        timestamp: json["timestamp"] is String ? int.parse(json["timestamp"]) : json["timestamp"],
        //No entiendo bien como funciona esta linea, pero lo que devuelve una lista desde el mapa desde el modelo y si viene null entrega una lista vacia
        products: json["products"]!=null? List<Product>.from(json["products"].map((model) => Product.fromJson(model)))??[]:[],
        client: json["client"]is String ? userFromJson( json["client"]):User.fromJson(json["client"])??{},
        address: json["address"]is String ? addressFromJson( json["address"]):Address.fromJson(json["address"])??{},
    
    
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "id_delivery": idDelivery,
        "id_address": idAddress,
        "status": status,
        "lat": lat,
        "lng": lng,
        "timestamp": timestamp,
        "products": products,
        "client": client,
        "address": address,
    };
    Order.fromJsonList(List<dynamic> jsonList) {
        if (jsonList == null) return;
        jsonList.forEach((element) {
          print(element);
          Order order = Order.fromJson(element);
          toList.add(order);
        });
    }
}
