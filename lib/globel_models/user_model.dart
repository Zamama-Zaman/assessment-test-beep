import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  final String? email;
  final String? password;
  final String? number;
  final String? userId;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.number,
    this.userId,
  });

  //*
  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      name: documentSnapshot.get('name'),
      email: documentSnapshot.get('email'),
      password: documentSnapshot.get('password'),
      number: documentSnapshot.get('number'),
      userId: documentSnapshot.get('userId'),
    );
  }

  //*
  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'number': number,
      'userId': userId,
    };
  }
}
