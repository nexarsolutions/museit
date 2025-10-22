import 'package:musit/globalModels/user_model.dart';

class RecipientResponseModel {
  int? statusCode;
  String? message;
  RecipientResponseData? response;

  RecipientResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  RecipientResponseModel copyWith({
    int? statusCode,
    String? message,
    RecipientResponseData? response,
  }) =>
      RecipientResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory RecipientResponseModel.fromJson(Map<String, dynamic> json) =>
      RecipientResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        response: json["response"] == null
            ? null
            : RecipientResponseData.fromJson(json["response"]),
      );
}

class RecipientResponseData {
  int? count;
  List<RecipientUserModel>? recipientUsers;

  RecipientResponseData({
    this.count,
    this.recipientUsers,
  });

  RecipientResponseData copyWith({
    int? count,
    List<RecipientUserModel>? recipientUsers,
  }) =>
      RecipientResponseData(
        count: count ?? this.count,
        recipientUsers: recipientUsers ?? this.recipientUsers,
      );

  factory RecipientResponseData.fromJson(Map<String, dynamic> json) =>
      RecipientResponseData(
        count: json["count"],
        recipientUsers: json["rows"] == null
            ? []
            : List<RecipientUserModel>.from(
                json["rows"]!.map((x) => RecipientUserModel.fromJson(x))),
      );
}

class RecipientUserModel {
  int? id;
  int? fromUserId;
  int? toUserId;
  int? playlistId;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? toUser;

  RecipientUserModel({
    this.id,
    this.fromUserId,
    this.toUserId,
    this.playlistId,
    this.createdAt,
    this.updatedAt,
    this.toUser,
  });

  RecipientUserModel copyWith({
    int? id,
    int? fromUserId,
    int? toUserId,
    int? playlistId,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? toUser,
  }) =>
      RecipientUserModel(
        id: id ?? this.id,
        fromUserId: fromUserId ?? this.fromUserId,
        toUserId: toUserId ?? this.toUserId,
        playlistId: playlistId ?? this.playlistId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        toUser: toUser ?? this.toUser,
      );

  factory RecipientUserModel.fromJson(Map<String, dynamic> json) =>
      RecipientUserModel(
        id: json["id"],
        fromUserId: json["fromUserId"],
        toUserId: json["toUserId"],
        playlistId: json["playlistId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        toUser:
            json["ToUser"] == null ? null : UserModel.fromJson(json["ToUser"]),
      );
}
