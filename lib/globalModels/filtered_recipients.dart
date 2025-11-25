import 'package:musit/globalModels/user_model.dart';

class FilteredRecipientResponseModel {
  int? statusCode;
  String? message;
  List<UserModel>? response;

  FilteredRecipientResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  FilteredRecipientResponseModel copyWith({
    int? statusCode,
    String? message,
    List<UserModel>? response,
  }) =>
      FilteredRecipientResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory FilteredRecipientResponseModel.fromJson(Map<String, dynamic> json) =>
      FilteredRecipientResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        response: json["response"] == null
            ? []
            : List<UserModel>.from(
                json["response"]!.map((x) => UserModel.fromJson(x))),
      );
}
