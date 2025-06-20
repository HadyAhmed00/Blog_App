import 'package:blog/features/auth/domain/entities/user_entitie.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
    id: map['id'],
    name: map['user_metadata']['Name'],
    email: map['email'],
  );
}
