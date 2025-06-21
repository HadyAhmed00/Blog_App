import 'package:blog/core/entities/user_entitie.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
    id: map['id'],
    name: map['user_metadata']['Name'],
    email: map['email'],
  );

  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
