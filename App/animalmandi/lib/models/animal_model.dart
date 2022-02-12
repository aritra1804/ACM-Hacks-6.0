
import 'dart:convert';
class AnimalModel{
  static List<Animal> animals=[];
}
class Animal {
  Animal({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}


class Animals {
  Animals({
    required this.animals,
  });

  List<Animal> animals;

  factory Animals.fromJson(Map<String, dynamic> json) => Animals(
    animals: List<Animal>.from(json["animals"].map((x) => Animal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "animals": List<dynamic>.from(animals.map((x) => x.toJson())),
  };
}

