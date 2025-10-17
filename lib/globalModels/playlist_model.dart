import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PlaylistResponseModel {
  int? statusCode;
  String? message;
  PlayListResponseData? response;

  PlaylistResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  PlaylistResponseModel copyWith({
    int? statusCode,
    String? message,
    PlayListResponseData? response,
  }) =>
      PlaylistResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory PlaylistResponseModel.fromJson(Map<String, dynamic> json) =>
      PlaylistResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        response: json["response"] == null
            ? null
            : PlayListResponseData.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "response": response?.toJson(),
      };
}

class PlayListResponseData {
  int? count;
  List<PlaylistModel>? playLists;

  PlayListResponseData({
    this.count,
    this.playLists,
  });

  PlayListResponseData copyWith({
    int? count,
    List<PlaylistModel>? playLists,
  }) =>
      PlayListResponseData(
        count: count ?? this.count,
        playLists: playLists ?? this.playLists,
      );

  factory PlayListResponseData.fromJson(Map<String, dynamic> json) =>
      PlayListResponseData(
        count: json["count"],
        playLists: json["rows"] == null
            ? []
            : List<PlaylistModel>.from(
                json["rows"]!.map((x) => PlaylistModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": playLists == null
            ? []
            : List<dynamic>.from(playLists!.map((x) => x.toJson())),
      };
}

class PlaylistModel {
  String? purposeName;
  int? id;
  int? userId;
  TextEditingController title;
  RxString image;
  int? purposeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isSaved;
  List<SongModel>? songs;

  PlaylistModel({
    this.purposeName,
    this.id,
    this.userId,
    TextEditingController? title,
    RxString? image,
    this.purposeId,
    this.createdAt,
    this.updatedAt,
    this.isSaved,
    this.songs,
  })  : title = title ?? TextEditingController(),
        image = image ?? RxString('');

  PlaylistModel copyWith({
    String? purposeName,
    int? id,
    int? userId,
    TextEditingController? title,
    RxString? image,
    int? purposeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? isSaved,
    List<SongModel>? songs,
  }) =>
      PlaylistModel(
        purposeName: purposeName ?? this.purposeName,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        image: image ?? this.image,
        purposeId: purposeId ?? this.purposeId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isSaved: isSaved ?? this.isSaved,
        songs: songs ?? this.songs,
      );

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
        purposeName: json["purposeName"],
        id: json["id"],
        userId: json["userId"],
        title: TextEditingController(text: json["title"] ?? ''),
        image: RxString(json["image"] ?? ''),
        purposeId: json["purposeId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        isSaved: json["isSaved"],
        songs: json["Songs"] == null
            ? []
            : List<SongModel>.from(
                json["Songs"]!.map((x) => SongModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "purposeName": purposeName,
        "id": id,
        "userId": userId,
        "title": title.text.trim(),
        "image": image,
        "purposeId": purposeId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isSaved": isSaved,
        "Songs": songs == null
            ? []
            : List<dynamic>.from(songs!.map((x) => x.toJson())),
      };
}

class SongModel {
  int? id;
  String? name;
  String? link;

  SongModel({
    this.id,
    this.name,
    this.link,
  });

  SongModel copyWith({
    int? id,
    String? name,
    String? link,
  }) =>
      SongModel(
        id: id ?? this.id,
        name: name ?? this.name,
        link: link ?? this.link,
      );

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        id: json["id"],
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
      };
}
