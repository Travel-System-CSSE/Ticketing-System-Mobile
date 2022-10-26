import 'dart:convert';

class User {
  final String id;
  final String name;
  final String idNumber;
  final String role;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.idNumber,
    required this.role,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'idNumber': idNumber,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user']['userId'] as String,
      name: map['user']['name'] as String,
      idNumber: map['user']['idNumber'] as String,
      role: map['user']['role'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
