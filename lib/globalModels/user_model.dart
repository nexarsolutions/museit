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
      id: json['id'],
      username: TextEditingController(text: json['username'] ?? ''),
      email: TextEditingController(text: json['email'] ?? ''),
      phone: TextEditingController(text: json['phone'] ?? ''),
      statusId: json['statusId'],
      roleId: json['roleId'],
      token: json['token'],
      profile: RxString(json['profile'] ?? ''),
      currentRoleId: json['currentRoleId'],
      availableRoles:
          List<int>.from(json['availableRoles']?.map((e) => e) ?? []),
      charity: json['charity'] != null
          ? UserCharity.fromJson(json['charity'])
          : json['CharityProfile'] != null
              ? UserCharity.fromJson(json['CharityProfile'])
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

  Map<String, String> toUpdateCustomerJson() {
    return {
      "username": username.text.trim(),
      "phone": phone.text.trim(),
    };
  }
}

class UserCharity {
  int? id;
  String? organtization;
  String? address;

  UserCharity({
    this.id,
    this.organtization,
    this.address,
  });

  factory UserCharity.fromJson(Map<String, dynamic> json) {
    return UserCharity(
      id: json['id'],
      organtization: json['organtization'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toSharedJson() {
    return {
      'id': id,
      'organtization': organtization,
      'address': address,
    };
  }
}

class ReceiptResponseModel {
  int? statusCode;
  String? message;
  ReceiptResponseData? response;

  ReceiptResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  ReceiptResponseModel copyWith({
    int? statusCode,
    String? message,
    ReceiptResponseData? response,
  }) =>
      ReceiptResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory ReceiptResponseModel.fromJson(Map<String, dynamic> json) =>
      ReceiptResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        response: json["response"] == null
            ? null
            : ReceiptResponseData.fromJson(json["response"]),
      );
}

class ReceiptResponseData {
  int? count;
  List<UserModel>? users;

  ReceiptResponseData({
    this.count,
    this.users,
  });

  ReceiptResponseData copyWith({
    int? count,
    List<UserModel>? users,
  }) =>
      ReceiptResponseData(
        count: count ?? this.count,
        users: users ?? this.users,
      );

  factory ReceiptResponseData.fromJson(Map<String, dynamic> json) =>
      ReceiptResponseData(
        count: json["count"],
        users: json["rows"] == null
            ? []
            : List<UserModel>.from(
                json["rows"]!.map((x) => UserModel.fromJson(x))),
      );
}
