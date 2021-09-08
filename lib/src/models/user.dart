// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:en_corto/src/models/role.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.id,
        this.email,
        this.password,
        this.name,
        this.lastname,
        this.phone,
        this.image,
        this.sessionToken,
        this.roles
        // this.createdAt,
        // this.updatedAt,
    });

    String id;
    String email;
    String password;
    String name;
    String lastname;
    String phone;
    String image;
    String sessionToken;
    List<Role> roles;
    // DateTime createdAt;
    // DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        image: json["image"],
        sessionToken: json["session_token"],
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))) ?? [],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "session_token": sessionToken,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
    };
}
