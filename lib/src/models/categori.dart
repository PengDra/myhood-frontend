/// Esta clase representa una categoria.
/// posee un metodo ToJson que convierte la direccion en un JSON.
/// posee un metodo fromJson que convierte un JSON en una direccion.
/// posee un metodo fromJsonList que convierte una lista de JSON en una lista de direcciones.
/// se llama categori ocn (I) por que existe una clase del framework que se llama category y me causaba muchos problemas. 
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
    List<Categori> toList = [];

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
    Categori.fromJsonList(List<dynamic> jsonList) {
        if (jsonList == null) return;
        jsonList.forEach((element) {
          print(element);
          Categori categori = Categori.fromJson(element);
          toList.add(categori);
        });
    }
}
