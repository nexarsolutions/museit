// import 'package:musit/globalModels/playlist_model.dart';
//
// class SentPlaylistResponseModel {
//   int? statusCode;
//   String? message;
//   SentPlaylistResponseData? response;
//
//   SentPlaylistResponseModel({
//     this.statusCode,
//     this.message,
//     this.response,
//   });
//
//   SentPlaylistResponseModel copyWith({
//     int? statusCode,
//     String? message,
//     SentPlaylistResponseData? response,
//   }) =>
//       SentPlaylistResponseModel(
//         statusCode: statusCode ?? this.statusCode,
//         message: message ?? this.message,
//         response: response ?? this.response,
//       );
//
//   factory SentPlaylistResponseModel.fromJson(Map<String, dynamic> json) =>
//       SentPlaylistResponseModel(
//         statusCode: json["statusCode"],
//         message: json["message"],
//         response: json["response"] == null
//             ? null
//             : SentPlaylistResponseData.fromJson(json["response"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "message": message,
//         "response": response?.toJson(),
//       };
// }
//
// class SentPlaylistResponseData {
//   int? count;
//   List<SentPlaylistModel>? sentPlaylists;
//
//   SentPlaylistResponseData({
//     this.count,
//     this.sentPlaylists,
//   });
//
//   SentPlaylistResponseData copyWith({
//     int? count,
//     List<SentPlaylistModel>? sentPlaylists,
//   }) =>
//       SentPlaylistResponseData(
//         count: count ?? this.count,
//         sentPlaylists: sentPlaylists ?? this.sentPlaylists,
//       );
//
//   factory SentPlaylistResponseData.fromJson(Map<String, dynamic> json) =>
//       SentPlaylistResponseData(
//         count: json["count"],
//         sentPlaylists: json["rows"] == null
//             ? []
//             : List<SentPlaylistModel>.from(
//                 json["rows"]!.map((x) => SentPlaylistModel.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "count": count,
//         "rows": sentPlaylists == null
//             ? []
//             : List<dynamic>.from(sentPlaylists!.map((x) => x.toJson())),
//       };
// }
//
// class SentPlaylistModel {
//   String? typeName;
//   int? id;
//   int? typeId;
//   int? fromUserId;
//   int? toUserId;
//   int? playlistId;
//   int? voiceNoteId;
//   dynamic paidSongsId;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   PlaylistModel? playlist;
//
//   SentPlaylistModel({
//     this.typeName,
//     this.id,
//     this.typeId,
//     this.fromUserId,
//     this.toUserId,
//     this.playlistId,
//     this.voiceNoteId,
//     this.paidSongsId,
//     this.createdAt,
//     this.updatedAt,
//     this.playlist,
//   });
//
//   SentPlaylistModel copyWith({
//     String? typeName,
//     int? id,
//     int? typeId,
//     int? fromUserId,
//     int? toUserId,
//     int? playlistId,
//     int? voiceNoteId,
//     dynamic paidSongsId,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     PlaylistModel? playlist,
//   }) =>
//       SentPlaylistModel(
//         typeName: typeName ?? this.typeName,
//         id: id ?? this.id,
//         typeId: typeId ?? this.typeId,
//         fromUserId: fromUserId ?? this.fromUserId,
//         toUserId: toUserId ?? this.toUserId,
//         playlistId: playlistId ?? this.playlistId,
//         voiceNoteId: voiceNoteId ?? this.voiceNoteId,
//         paidSongsId: paidSongsId ?? this.paidSongsId,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         playlist: playlist ?? this.playlist,
//       );
//
//   factory SentPlaylistModel.fromJson(Map<String, dynamic> json) =>
//       SentPlaylistModel(
//         typeName: json["typeName"],
//         id: json["id"],
//         typeId: json["typeId"],
//         fromUserId: json["fromUserId"],
//         toUserId: json["toUserId"],
//         playlistId: json["playlistId"],
//         voiceNoteId: json["voiceNoteId"],
//         paidSongsId: json["paidSongsId"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         playlist: json["Playlist"] == null
//             ? null
//             : PlaylistModel.fromJson(json["Playlist"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "typeName": typeName,
//         "id": id,
//         "typeId": typeId,
//         "fromUserId": fromUserId,
//         "toUserId": toUserId,
//         "playlistId": playlistId,
//         "voiceNoteId": voiceNoteId,
//         "paidSongsId": paidSongsId,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "Playlist": playlist?.toJson(),
//       };
// }
