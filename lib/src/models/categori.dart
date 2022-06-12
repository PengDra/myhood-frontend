// To parse this JSON data, do
//
//     final categori = categoriFromJson(jsonString);

import 'dart:convert';

Categori categoriFromJson(String str) => Categori.fromJson(json.decode(str));

String categoriToJson(Categori data) => json.encode(data.toJson());

class Categori {
    Categori({
        this.id,
        this.name,
        this.description,
    });

    String id;
    String name;
    String description;

    factory Categori.fromJson(Map<String, dynamic> json) => Categori(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}
