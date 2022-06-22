/// Esta clase representa una producto.
/// posee un metodo ToJson que convierte la producto en un JSON.
/// posee un metodo fromJson que convierte un JSON en una producto.
/// posee un metodo fromJsonList que convierte una lista de JSON en una lista de productos.



import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
    String name;
    String description;
    String image1;
    String image2;
    String image3;
    int price;
    int idCategory;
    int cuantity;
    List<Product> toList =[];
    
    Product({
        this.id,
        this.name,
        this.description,
        this.image1,
        this.image2,
        this.image3,
        this.price,
        this.idCategory,
        this.cuantity,
    });

    

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"]is int ? json["id"].toString() : json["id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        price: json["price"] is String ? int.parse(json["price"] ) : json["price"],
        idCategory: json["id_category"] is String ? int.parse(json["id_category"] ) : json["id_category"],
        cuantity: json["cuantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "price": price,
        "id_category": idCategory,
        "cuantity": cuantity,
    };
    Product.fromJsonList(List<dynamic> jsonList) {
        if (jsonList == null) return;
        jsonList.forEach((element) {
          print(element);
          Product product = Product.fromJson(element);
          toList.add(product);
        });
    }
}
