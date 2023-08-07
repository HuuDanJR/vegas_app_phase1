// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'auth.model.g.dart';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

@JsonSerializable()
@HiveType(typeId: 0)
class AuthModel {
  AuthModel({
    this.iss,
    this.iat,
    this.jti,
    this.user,
  });
  @HiveField(0)
  @JsonKey(name: "iss")
  String? iss;
  @HiveField(1)
  @JsonKey(name: "iat")
  String? iat;
  @HiveField(2)
  @JsonKey(name: "jti")
  String? jti;
  @HiveField(3)
  @JsonKey(name: "user")
  User? user;

  AuthModel copyWith({
    String? iss,
    String? iat,
    String? jti,
    User? user,
  }) =>
      AuthModel(
        iss: iss ?? this.iss,
        iat: iat ?? this.iat,
        jti: jti ?? this.jti,
        user: user ?? this.user,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 1)
class User {
  User({
    this.id,
    this.email,
    this.name,
    this.birthday,
    this.customerId,
  });
  @HiveField(0)
  @JsonKey(name: "id")
  int? id;
  @HiveField(2)
  @JsonKey(name: "email")
  String? email;
  @HiveField(3)
  @JsonKey(name: "name")
  String? name;
  @HiveField(4)
  @JsonKey(name: "birthday")
  String? birthday;
  @HiveField(5)
  @JsonKey(name: "customer_id")
  int? customerId;

  User copyWith({
    int? id,
    String? email,
    String? name,
    String? birthday,
    int? customerId,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        birthday: birthday ?? this.birthday,
        customerId: customerId ?? this.customerId,
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
