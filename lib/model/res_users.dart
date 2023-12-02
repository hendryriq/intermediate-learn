// To parse this JSON data, do
//
//     final resGetUsers = resGetUsersFromJson(jsonString);

import 'dart:convert';

ResGetUsers resGetUsersFromJson(String str) => ResGetUsers.fromJson(json.decode(str));

String resGetUsersToJson(ResGetUsers data) => json.encode(data.toJson());

class ResGetUsers {
  bool? isSuccess;
  String? message;
  List<GetUsers>? data;

  ResGetUsers({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ResGetUsers.fromJson(Map<String, dynamic> json) => ResGetUsers(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: json["data"] == null ? [] : List<GetUsers>.from(json["data"]!.map((x) => GetUsers.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetUsers {
  String? id;
  String? username;
  String? email;
  String? password;
  String? fullname;
  DateTime? tglDaftar;

  GetUsers({
    this.id,
    this.username,
    this.email,
    this.password,
    this.fullname,
    this.tglDaftar,
  });

  factory GetUsers.fromJson(Map<String, dynamic> json) => GetUsers(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    fullname: json["fullname"],
    tglDaftar: json["tgl_daftar"] == null ? null : DateTime.parse(json["tgl_daftar"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "password": password,
    "fullname": fullname,
    "tgl_daftar": tglDaftar?.toIso8601String(),
  };
}
