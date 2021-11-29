import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name, email, id;

  UserModel({this.name, this.email, this.id});

  factory UserModel.fromJson(DocumentSnapshot user) =>
      UserModel(name: user['name'], email: user['email'], id: user.id);
}
