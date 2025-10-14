import 'package:flutter/material.dart';

class UserModel {
  TextEditingController username;
  TextEditingController email;
  TextEditingController phone;
  int roleId; //1- sender/muse, 2- receiver/charity, 3- charity organization
  int? id;
  int? statusId;
  String? token;

  UserModel({
    TextEditingController? username,
    TextEditingController? email,
    TextEditingController? phone,
    int? roleId,
    this.id,
    this.statusId,
    this.token,
  })  : username = username ?? TextEditingController(),
        email = email ?? TextEditingController(),
        phone = phone ?? TextEditingController(),
        roleId = roleId ?? 0;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: TextEditingController(text: json['username'] ?? ''),
      email: TextEditingController(text: json['email'] ?? ''),
      phone: TextEditingController(text: json['phone'] ?? ''),
      roleId: json['roleId'],
      id: json['id'],
      statusId: json['statusId'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toSignupViaEmailJson() {
    return {
      'username': username.text,
      'email': email.text,
      'phone': phone.text,
      'roleId': roleId,
      //add password
    };
  }

  Map<String, dynamic> toSharedJson() {
    return {
      'username': username.text,
      'email': email.text,
      'phone': phone.text,
      'roleId': roleId,
      'id': id,
      'statusId': statusId,
      'token': token,
    
    };
  }
}
