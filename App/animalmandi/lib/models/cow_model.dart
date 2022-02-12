import 'dart:convert';



class Animaldetails {
  Animaldetails({
    required this.id,
    required this.type,
    required this.image,
    required this.age,
    required this.description,
    required this.price,
    required this.typeInEng,
    required this.name,
  });

  String id;
  String type;
  String image;
  String age;
  String description;
  String price;
  String typeInEng;
  String name;

  factory Animaldetails.fromJson(Map<String, dynamic> json) => Animaldetails(
        id: json["_id"],
        type: json["type"],
        image: json["image"],
        age: json["age"],
        description: json["description"],
        price: json["price"],
        typeInEng: json["typeInEng"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "image": image,
        "age": age,
        "description": description,
        "price": price,
        "typeInEng": typeInEng,
        "name": name,
      };
}
