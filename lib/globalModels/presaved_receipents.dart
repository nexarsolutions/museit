import 'package:musit/globalModels/user_model.dart';

class PreSavedRecipientResponseModel {
  int? statusCode;
  String? message;
  PreSavedRecipientResponseData? response;

  PreSavedRecipientResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  PreSavedRecipientResponseModel copyWith({
    int? statusCode,
    String? message,
    PreSavedRecipientResponseData? response,
  }) =>
      PreSavedRecipientResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory PreSavedRecipientResponseModel.fromJson(Map<String, dynamic> json) =>
      PreSavedRecipientResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        response: json["response"] == null
            ? null
            : PreSavedRecipientResponseData.fromJson(json["response"]),
      );
}

class PreSavedRecipientResponseData {
  int? count;
  List<PreSavedRecipient>? rows;

  PreSavedRecipientResponseData({
    this.count,
    this.rows,
  });

  PreSavedRecipientResponseData copyWith({
    int? count,
    List<PreSavedRecipient>? rows,
  }) =>
      PreSavedRecipientResponseData(
        count: count ?? this.count,
        rows: rows ?? this.rows,
      );

  factory PreSavedRecipientResponseData.fromJson(Map<String, dynamic> json) =>
      PreSavedRecipientResponseData(
        count: json["count"],
        rows: json["rows"] == null
            ? []
            : List<PreSavedRecipient>.from(
                json["rows"]!.map((x) => PreSavedRecipient.fromJson(x))),
      );
}

class PreSavedRecipient {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? picture;
  UserModel? recipient;

  PreSavedRecipient({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.picture,
    this.recipient,
  });

  PreSavedRecipient copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? picture,
    UserModel? recipient,
  }) =>
      PreSavedRecipient(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        picture: picture ?? this.picture,
        recipient: recipient ?? this.recipient,
      );

  factory PreSavedRecipient.fromJson(Map<String, dynamic> json) =>
      PreSavedRecipient(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        picture: json["picture"],
        recipient: json["Recipient"] == null
            ? null
            : UserModel.fromJson(json["Recipient"]),
      );
}
