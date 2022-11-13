import 'package:equatable/equatable.dart';
import 'dart:convert';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  //* For encoding decoading
  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  //* Convert json to Dart classes
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
      );

  //* Convert class to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };

  //* For value equality
  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}

class Rating extends Equatable {
  const Rating({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  //* Decoading json
  factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));

  //* Encoading json
  String toRawJson() => json.encode(toJson());

  //* Convert json to Dart classes
  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  //* Convert class to json
  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };

  //* For value Equality
  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
