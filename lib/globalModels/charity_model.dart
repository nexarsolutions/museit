// lib/models/charity_model.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharityModel {
  TextEditingController organizationName;
  TextEditingController address;
  RxString registrationCertificate;
  TextEditingController bankName;
  TextEditingController accountNumber;
  TextEditingController accountTitle;
  TextEditingController ownerId;
  RxString frontId;
  RxString backId;
  RxString faceRecognition;

  CharityModel({
    TextEditingController? organizationName,
    TextEditingController? address,
    RxString? registrationCertificate,
    TextEditingController? bankName,
    TextEditingController? accountNumber,
    TextEditingController? accountTitle,
    TextEditingController? ownerId,
    RxString? frontId,
    RxString? backId,
    RxString? faceRecognition,
  })  : organizationName = organizationName ?? TextEditingController(),
        address = address ?? TextEditingController(),
        bankName = bankName ?? TextEditingController(),
        accountNumber = accountNumber ?? TextEditingController(),
        accountTitle = accountTitle ?? TextEditingController(),
        ownerId = ownerId ?? TextEditingController(),
        registrationCertificate = registrationCertificate ?? RxString(''),
        frontId = frontId ?? RxString(''),
        backId = backId ?? RxString(''),
        faceRecognition = faceRecognition ?? RxString('');

  Map<String, dynamic> toJson() {
    return {
      "organtization": organizationName.text.trim(),
      "address": address.text.trim(),
      "regCertificate": registrationCertificate.value,
      "bankName": bankName.text.trim(),
      "accountNumber": accountNumber.text.trim(),
      "accountTitle": accountTitle.text.trim(),
      "ownerId": ownerId.text.trim(),
      "frontId": frontId.value,
      "backId": backId.value,
      "faceRecognition": faceRecognition.value,
    };
  }

  void dispose() {
    organizationName.dispose();
    address.dispose();
    bankName.dispose();
    accountNumber.dispose();
    accountTitle.dispose();
    ownerId.dispose();
  }
}
