import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserModel {
  TextEditingController username;
  int roleId; //1- sender/muse, 2- receiver/charity, 3- charity organization
  int? id;
  TextEditingController email;
  TextEditingController phone;
  RxString profile;
  int? statusId;
  String? token;
  int? currentRoleId;
  List<int> availableRoles;
  UserCharity? charity;

  UserModel({
    TextEditingController? username,
    TextEditingController? email,
    TextEditingController? phone,
    int? roleId,
    this.id,
    this.statusId,
    this.token,
    RxString? profile,
    this.currentRoleId,
    List<int>? availableRoles,
    this.charity,
  })  : username = username ?? TextEditingController(),
        email = email ?? TextEditingController(),
        phone = phone ?? TextEditingController(),
        roleId = roleId ?? (-1),
        profile = profile ?? RxString(''),
        availableRoles = availableRoles ?? [];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: TextEditingController(text: json['username'] ?? ''),
      email: TextEditingController(text: json['email'] ?? ''),
      phone: TextEditingController(text: json['phone'] ?? ''),
      roleId: json['roleId'],
      id: json['id'],
      statusId: json['statusId'],
      token: json['token'],
      profile: RxString(json['profile'] ?? ''),
      currentRoleId: json['currentRoleId'],
      availableRoles:
          List<int>.from(json['availableRoles']?.map((e) => e) ?? []),
      charity: json['charity'] != null
          ? UserCharity.fromJson(json['charity'])
          : null,
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
      'profile': profile.value,
      'currentRoleId': currentRoleId,
      'availableRoles': availableRoles,
      'charity': charity?.toSharedJson(),
    };
  }
}

class UserCharity {
  int? id;
  String? organtization;

  UserCharity({
    this.id,
    this.organtization,
  });

  factory UserCharity.fromJson(Map<String, dynamic> json) {
    return UserCharity(
      id: json['id'],
      organtization: json['organtization'],
    );
  }

  Map<String, dynamic> toSharedJson() {
    return {
      'id': id,
      'organtization': organtization,
    };
  }
}
