import 'package:musit/globalModels/song_model.dart';

class ReceivedSongsResponseModel {
  int? statusCode;
  String? message;
  ReceivedSongsResponseData? response;

  ReceivedSongsResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  ReceivedSongsResponseModel copyWith({
    int? statusCode,
    String? message,
    ReceivedSongsResponseData? response,
  }) =>
      ReceivedSongsResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory ReceivedSongsResponseModel.fromJson(Map<String, dynamic> json) => ReceivedSongsResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    response: json["response"] == null ? null : ReceivedSongsResponseData.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "response": response?.toJson(),
  };
}

class ReceivedSongsResponseData {
  int? count;
  List<ReceiveSongModel>? rows;

  ReceivedSongsResponseData({
    this.count,
    this.rows,
  });

  ReceivedSongsResponseData copyWith({
    int? count,
    List<ReceiveSongModel>? rows,
  }) =>
      ReceivedSongsResponseData(
        count: count ?? this.count,
        rows: rows ?? this.rows,
      );

  factory ReceivedSongsResponseData.fromJson(Map<String, dynamic> json) => ReceivedSongsResponseData(
    count: json["count"],
    rows: json["rows"] == null ? [] : List<ReceiveSongModel>.from(json["rows"]!.map((x) => ReceiveSongModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "rows": rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toJson())),
  };
}

class ReceiveSongModel {
  String? shareGroupId;
  DateTime? createdAt;
  FromUser? fromUser;
  List<SongModel>? items;

  ReceiveSongModel({
    this.shareGroupId,
    this.createdAt,
    this.fromUser,
    this.items,
  });

  ReceiveSongModel copyWith({
    String? shareGroupId,
    DateTime? createdAt,
    FromUser? fromUser,
    List<SongModel>? items,
  }) =>
      ReceiveSongModel(
        shareGroupId: shareGroupId ?? this.shareGroupId,
        createdAt: createdAt ?? this.createdAt,
        fromUser: fromUser ?? this.fromUser,
        items: items ?? this.items,
      );

  factory ReceiveSongModel.fromJson(Map<String, dynamic> json) => ReceiveSongModel(
    shareGroupId: json["shareGroupId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    fromUser: json["fromUser"] == null ? null : FromUser.fromJson(json["fromUser"]),
    items: json["items"] == null ? [] : List<SongModel>.from(json["items"]!.map((x) => SongModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shareGroupId": shareGroupId,
    "createdAt": createdAt?.toIso8601String(),
    "fromUser": fromUser?.toJson(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class FromUser {
  int? id;
  String? email;
  String? username;
  String? phone;
  String? profile;

  FromUser({
    this.id,
    this.email,
    this.username,
    this.phone,
    this.profile,
  });

  FromUser copyWith({
    int? id,
    String? email,
    String? username,
    String? phone,
    String? profile,
  }) =>
      FromUser(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        phone: phone ?? this.phone,
        profile: profile ?? this.profile,
      );

  factory FromUser.fromJson(Map<String, dynamic> json) => FromUser(
    id: json["id"],
    email: json["email"],
    username: json["username"],
    phone: json["phone"],
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "username": username,
    "phone": phone,
    "profile": profile,
  };
}
