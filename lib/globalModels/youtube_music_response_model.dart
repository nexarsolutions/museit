// class YoutubeMusicResponseModel {
//   int? statusCode;
//   String? message;
//   YoutubeMusicResponseData? response;
//
//   YoutubeMusicResponseModel({
//     this.statusCode,
//     this.message,
//     this.response,
//   });
//
//   YoutubeMusicResponseModel copyWith({
//     int? statusCode,
//     String? message,
//     YoutubeMusicResponseData? response,
//   }) =>
//       YoutubeMusicResponseModel(
//         statusCode: statusCode ?? this.statusCode,
//         message: message ?? this.message,
//         response: response ?? this.response,
//       );
//
//   factory YoutubeMusicResponseModel.fromJson(Map<String, dynamic> json) => YoutubeMusicResponseModel(
//     statusCode: json["statusCode"],
//     message: json["message"],
//     response: json["response"] == null ? null : YoutubeMusicResponseData.fromJson(json["response"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "statusCode": statusCode,
//     "message": message,
//     "response": response?.toJson(),
//   };
// }
//
// class YoutubeMusicResponseData {
//   List<YoutubeSongModel>? songs;
//   int? total;
//   int? limit;
//   String? nextPageToken;
//   bool? hasMore;
//
//   YoutubeMusicResponseData({
//     this.songs,
//     this.total,
//     this.limit,
//     this.nextPageToken,
//     this.hasMore,
//   });
//
//   YoutubeMusicResponseData copyWith({
//     List<YoutubeSongModel>? songs,
//     int? total,
//     int? limit,
//     String? nextPageToken,
//     bool? hasMore,
//   }) =>
//       YoutubeMusicResponseData(
//         songs: songs ?? this.songs,
//         total: total ?? this.total,
//         limit: limit ?? this.limit,
//         nextPageToken: nextPageToken ?? this.nextPageToken,
//         hasMore: hasMore ?? this.hasMore,
//       );
//
//   factory YoutubeMusicResponseData.fromJson(Map<String, dynamic> json) => YoutubeMusicResponseData(
//     songs: json["songs"] == null ? [] : List<YoutubeSongModel>.from(json["songs"]!.map((x) => YoutubeSongModel.fromJson(x))),
//     total: json["total"],
//     limit: json["limit"],
//     nextPageToken: json["nextPageToken"],
//     hasMore: json["hasMore"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "songs": songs == null ? [] : List<dynamic>.from(songs!.map((x) => x.toJson())),
//     "total": total,
//     "limit": limit,
//     "nextPageToken": nextPageToken,
//     "hasMore": hasMore,
//   };
// }
//
// class YoutubeSongModel {
//   String? id;
//   String? videoId;
//   String? title;
//   String? artistName;
//   String? thumbnail;
//   DateTime? publishedAt;
//   int? durationInSeconds;
//   String? duration;
//   String? url;
//
//   YoutubeSongModel({
//     this.id,
//     this.videoId,
//     this.title,
//     this.artistName,
//     this.thumbnail,
//     this.publishedAt,
//     this.durationInSeconds,
//     this.duration,
//     this.url,
//   });
//
//   YoutubeSongModel copyWith({
//     String? id,
//     String? videoId,
//     String? title,
//     String? artistName,
//     String? thumbnail,
//     DateTime? publishedAt,
//     int? durationInSeconds,
//     String? duration,
//     String? url,
//   }) =>
//       YoutubeSongModel(
//         id: id ?? this.id,
//         videoId: videoId ?? this.videoId,
//         title: title ?? this.title,
//         artistName: artistName ?? this.artistName,
//         thumbnail: thumbnail ?? this.thumbnail,
//         publishedAt: publishedAt ?? this.publishedAt,
//         durationInSeconds: durationInSeconds ?? this.durationInSeconds,
//         duration: duration ?? this.duration,
//         url: url ?? this.url,
//       );
//
//   factory YoutubeSongModel.fromJson(Map<String, dynamic> json) => YoutubeSongModel(
//     id: json["id"],
//     videoId: json["videoId"],
//     title: json["title"],
//     artistName: json["artistName"],
//     thumbnail: json["thumbnail"],
//     publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
//     durationInSeconds: json["durationInSeconds"],
//     duration: json["duration"],
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "videoId": videoId,
//     "title": title,
//     "artistName": artistName,
//     "thumbnail": thumbnail,
//     "publishedAt": publishedAt?.toIso8601String(),
//     "durationInSeconds": durationInSeconds,
//     "duration": duration,
//     "url": url,
//   };
// }
