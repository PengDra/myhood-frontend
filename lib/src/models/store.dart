import 'dart:convert';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
    Store({
        this.id,
        this.name,
        this.address,
        this.image,
        this.lat,
        this.lng,
        this.idUser,
    });

    String id;
    String name;
    String address;
    String image;
    double lat;
    double lng;
    String idUser;

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        name: json["name"],
        address: json["address"],
        image: json["image"],
        lat: json["lat"] is String ? double.parse(json["lat"]) : json["lat"],
        lng: json["lng"] is String ? double.parse(json["lng"]) : json["lng"],
        idUser: json["id_user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "image": image,
        "lat": lat,
        "lng": lng,
        "id_user": idUser,
    };
}