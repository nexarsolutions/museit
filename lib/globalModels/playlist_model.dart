import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musit/globalModels/song_model.dart';

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
  RxList<SongModel> songs;
  RxList<PlaylistVoiceModel> voiceNotes;
  PlayListUser? user;

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
    RxList<SongModel>? songs,
    RxList<PlaylistVoiceModel>? voiceNotes,
    this.user,
  })  : title = title ?? TextEditingController(),
        image = image ?? RxString(''),
        songs = songs ?? <SongModel>[].obs,
        voiceNotes = voiceNotes ?? <PlaylistVoiceModel>[].obs;

  PlaylistModel.copyWith(PlaylistModel other)
      : purposeName = other.purposeName,
        id = other.id,
        userId = other.userId,
        title = TextEditingController(text: other.title.text),
        image = RxString(other.image.value),
        purposeId = other.purposeId,
        createdAt = other.createdAt,
        updatedAt = other.updatedAt,
        isSaved = other.isSaved,
        songs = RxList<SongModel>.from(other.songs.map(
          (element) => element,
        )),
        voiceNotes = RxList<PlaylistVoiceModel>.from(other.voiceNotes.map(
          (element) => element,
        )),
        user = other.user != null ? PlayListUser.copy(other.user!) : null;

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
            ? <SongModel>[].obs
            : RxList<SongModel>.from(
                json["Songs"]?.map((x) => SongModel.fromJson(x) ?? [])),
        voiceNotes: json["voiceNotes"] == null
            ? <PlaylistVoiceModel>[].obs
            : RxList<PlaylistVoiceModel>.from(
                json["voiceNotes"]!.map((x) => PlaylistVoiceModel.fromJson(x))),
        user: json["User"] == null ? null : PlayListUser.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title.text.trim(),
        // "image": image.value,
        "purposeId": purposeId,
        "songs": songs
            .map(
              (element) => element.toJson(),
            )
            .toList(),
        // "voiceNotes": voiceNotes
        //     .map(
        //       (element) => element.toJson(),
        //     )
        //     .toList(),
      };

  /// ✅ Clears all reactive and controller data
  void clear() {
    purposeName = null;
    id = null;
    userId = null;
    purposeId = null;
    createdAt = null;
    updatedAt = null;
    isSaved = null;

    title.clear(); // clear TextEditingController
    image.value = ''; // reset RxString
    songs.clear(); // clear RxList
  }
}

class PlaylistVoiceModel {
  String? name;
  String? link;

  PlaylistVoiceModel({this.name, this.link});

  factory PlaylistVoiceModel.fromJson(Map<String, dynamic> json) =>
      PlaylistVoiceModel(
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name?.split('.').first,
        "link": link,
      };
}

class PlayListUser {
  int? id;
  String? username;
  String? profile;

  PlayListUser({this.id, this.username, this.profile});

  PlayListUser.copy(PlayListUser other)
      : id = other.id,
        username = other.username,
        profile = other.profile;

  factory PlayListUser.fromJson(Map<String, dynamic> json) {
    return PlayListUser(
      id: json['id'],
      username: json['username'],
      profile: json['profile'],
    );
  }
}