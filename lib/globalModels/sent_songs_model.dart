import 'package:musit/globalModels/song_model.dart';

class SentSongResponseModel {
  int? statusCode;
  String? message;
  SentSongResponseData? response;

  SentSongResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  SentSongResponseModel copyWith({
    int? statusCode,
    String? message,
    SentSongResponseData? response,
  }) =>
      SentSongResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory SentSongResponseModel.fromJson(Map<String, dynamic> json) => SentSongResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    response: json["response"] == null ? null : SentSongResponseData.fromJson(json["response"]),
  );


}

class SentSongResponseData {
  int? count;
  List<SentSongModel>? rows;

  SentSongResponseData({
    this.count,
    this.rows,
  });

  SentSongResponseData copyWith({
    int? count,
    List<SentSongModel>? rows,
  }) =>
      SentSongResponseData(
        count: count ?? this.count,
        rows: rows ?? this.rows,
      );

  factory SentSongResponseData.fromJson(Map<String, dynamic> json) => SentSongResponseData(
    count: json["count"],
    rows: json["rows"] == null ? [] : List<SentSongModel>.from(json["rows"]!.map((x) => SentSongModel.fromJson(x))),
  );


}

class SentSongModel {
  String? shareGroupId;
  DateTime? createdAt;
  List<SongModel>? items;
  List<Recipient>? recipients;
  List<String>? phoneNumbers;

  SentSongModel({
    this.shareGroupId,
    this.createdAt,
    this.items,
    this.recipients,
    this.phoneNumbers,
  });

  SentSongModel copyWith({
    String? shareGroupId,
    DateTime? createdAt,
    List<SongModel>? items,
    List<Recipient>? recipients,
    List<String>? phoneNumbers,
  }) =>
      SentSongModel(
        shareGroupId: shareGroupId ?? this.shareGroupId,
        createdAt: createdAt ?? this.createdAt,
        items: items ?? this.items,
        recipients: recipients ?? this.recipients,
        phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      );

  factory SentSongModel.fromJson(Map<String, dynamic> json) => SentSongModel(
    shareGroupId: json["shareGroupId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    items: json["items"] == null ? [] : List<SongModel>.from(json["items"]!.map((x) => SongModel.fromJson(x))),
    recipients: json["recipients"] == null ? [] : List<Recipient>.from(json["recipients"]!.map((x) => Recipient.fromJson(x))),
    phoneNumbers: json["phoneNumbers"] == null ? [] : List<String>.from(json["phoneNumbers"]!.map((x) => x)),
  );


}

class Recipient {
  int? id;
  String? email;
  String? username;
  String? phone;
  String? profile;

  Recipient({
    this.id,
    this.email,
    this.username,
    this.phone,
    this.profile,
  });

  Recipient copyWith({
    int? id,
    String? email,
    String? username,
    String? phone,
    String? profile,
  }) =>
      Recipient(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        phone: phone ?? this.phone,
        profile: profile ?? this.profile,
      );

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
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
