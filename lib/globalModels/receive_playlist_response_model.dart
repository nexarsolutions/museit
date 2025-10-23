import 'package:musit/globalModels/playlist_model.dart';
import 'package:musit/globalModels/song_model.dart';
import 'package:musit/globalModels/user_model.dart';

class ReceivePlaylistSongResponseModel {
  int? statusCode;
  String? message;
  ReceivePlaylistSongResponseData? response;

  ReceivePlaylistSongResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  ReceivePlaylistSongResponseModel copyWith({
    int? statusCode,
    String? message,
    ReceivePlaylistSongResponseData? response,
  }) =>
      ReceivePlaylistSongResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory ReceivePlaylistSongResponseModel.fromJson(
          Map<String, dynamic> json) =>
      ReceivePlaylistSongResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        response: json["response"] == null
            ? null
            : ReceivePlaylistSongResponseData.fromJson(json["response"]),
      );
}

class ReceivePlaylistSongResponseData {
  int? count;
  List<ReceivePlaylistSongModel>? receivedPlaylists;

  ReceivePlaylistSongResponseData({
    this.count,
    this.receivedPlaylists,
  });

  ReceivePlaylistSongResponseData copyWith({
    int? count,
    List<ReceivePlaylistSongModel>? receivedPlaylists,
  }) =>
      ReceivePlaylistSongResponseData(
        count: count ?? this.count,
        receivedPlaylists: receivedPlaylists ?? this.receivedPlaylists,
      );

  factory ReceivePlaylistSongResponseData.fromJson(Map<String, dynamic> json) =>
      ReceivePlaylistSongResponseData(
        count: json["count"],
        receivedPlaylists: json["rows"] == null
            ? []
            : List<ReceivePlaylistSongModel>.from(
                json["rows"]!.map((x) => ReceivePlaylistSongModel.fromJson(x))),
      );
}

class ReceivePlaylistSongModel {
  String? typeName;
  int? id;
  int? typeId;
  int? fromUserId;
  int? toUserId;
  int? playlistId;
  int? voiceNoteId;
  int? paidSongsId;
  DateTime? createdAt;
  DateTime? updatedAt;
  PlaylistModel? playlist;
  SongModel? paidSongs;
  ReceivedPlaylistVoiceNote? voiceNote;
  UserModel? fromUser;

  ReceivePlaylistSongModel({
    this.typeName,
    this.id,
    this.typeId,
    this.fromUserId,
    this.toUserId,
    this.playlistId,
    this.voiceNoteId,
    this.paidSongsId,
    this.createdAt,
    this.updatedAt,
    this.playlist,
    this.paidSongs,
    this.voiceNote,
    this.fromUser,
  });

  ReceivePlaylistSongModel copyWith({
    String? typeName,
    int? id,
    int? typeId,
    int? fromUserId,
    int? toUserId,
    int? playlistId,
    int? voiceNoteId,
    int? paidSongsId,
    DateTime? createdAt,
    DateTime? updatedAt,
    PlaylistModel? playlist,
    SongModel? paidSongs,
    ReceivedPlaylistVoiceNote? voiceNote,
    UserModel? fromUser,
  }) =>
      ReceivePlaylistSongModel(
        typeName: typeName ?? this.typeName,
        id: id ?? this.id,
        typeId: typeId ?? this.typeId,
        fromUserId: fromUserId ?? this.fromUserId,
        toUserId: toUserId ?? this.toUserId,
        playlistId: playlistId ?? this.playlistId,
        voiceNoteId: voiceNoteId ?? this.voiceNoteId,
        paidSongsId: paidSongsId ?? this.paidSongsId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        playlist: playlist ?? this.playlist,
        paidSongs: paidSongs ?? this.paidSongs,
        voiceNote: voiceNote ?? this.voiceNote,
        fromUser: fromUser ?? this.fromUser,
      );

  factory ReceivePlaylistSongModel.fromJson(Map<String, dynamic> json) =>
      ReceivePlaylistSongModel(
        typeName: json["typeName"],
        id: json["id"],
        typeId: json["typeId"],
        fromUserId: json["fromUserId"],
        toUserId: json["toUserId"],
        playlistId: json["playlistId"],
        voiceNoteId: json["voiceNoteId"],
        paidSongsId: json["paidSongsId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        playlist: json["Playlist"] == null
            ? null
            : PlaylistModel.fromJson(json["Playlist"]),
        paidSongs: json["PaidSongs"] == null
            ? null
            : SongModel.fromJson(json["PaidSongs"]),
        voiceNote: json["VoiceNote"] == null
            ? null
            : ReceivedPlaylistVoiceNote.fromJson(json["VoiceNote"]),
        fromUser: json["FromUser"] == null
            ? null
            : UserModel.fromJson(json["FromUser"]),
      );
}

class ReceivedPlaylistVoiceNote {
  int? id;
  DateTime? createdAt;
  String? name;
  String? link;

  ReceivedPlaylistVoiceNote({
    this.id,
    this.createdAt,
    this.name,
    this.link,
  });

  ReceivedPlaylistVoiceNote copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    String? link,
  }) =>
      ReceivedPlaylistVoiceNote(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        link: link ?? this.link,
      );

  factory ReceivedPlaylistVoiceNote.fromJson(Map<String, dynamic> json) =>
      ReceivedPlaylistVoiceNote(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "name": name,
        "link": link,
      };
}
