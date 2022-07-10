import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
    Payment({
        this.id,
        this.idOrder,
        this.idDelivery,
        this.amount,
    });

    String id;
    String idOrder;
    String idDelivery;
    String amount;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        idOrder: json["idOrder"],
        idDelivery: json["idDelivery"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idOrder": idOrder,
        "idDelivery": idDelivery,
        "amount": amount,
    };
}
