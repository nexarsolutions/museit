class AdminSongsResponseModel {
  int? statusCode;
  String? message;
  AdminSongsResponseData? response;

  AdminSongsResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  AdminSongsResponseModel copyWith({
    int? statusCode,
    String? message,
    AdminSongsResponseData? response,
  }) =>
      AdminSongsResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory AdminSongsResponseModel.fromJson(Map<String, dynamic> json) => AdminSongsResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    response: json["response"] == null ? null : AdminSongsResponseData.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "response": response?.toJson(),
  };
}

class AdminSongsResponseData {
  int? count;
  List<AdminSongsModel>? rows;

  AdminSongsResponseData({
    this.count,
    this.rows,
  });

  AdminSongsResponseData copyWith({
    int? count,
    List<AdminSongsModel>? rows,
  }) =>
      AdminSongsResponseData(
        count: count ?? this.count,
        rows: rows ?? this.rows,
      );

  factory AdminSongsResponseData.fromJson(Map<String, dynamic> json) => AdminSongsResponseData(
    count: json["count"],
    rows: json["rows"] == null ? [] : List<AdminSongsModel>.from(json["rows"]!.map((x) => AdminSongsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "rows": rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toJson())),
  };
}

class AdminSongsModel {
  int? id;
  String? name;
  String? link;
  dynamic typeId;
  dynamic userId;
  String? author;
  String? genre;
  String? album;
  int? year;
  String? duration;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  AdminSongsModel({
    this.id,
    this.name,
    this.link,
    this.typeId,
    this.userId,
    this.author,
    this.genre,
    this.album,
    this.year,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  AdminSongsModel copyWith({
    int? id,
    String? name,
    String? link,
    dynamic typeId,
    dynamic userId,
    String? author,
    String? genre,
    String? album,
    int? year,
    String? duration,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      AdminSongsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        link: link ?? this.link,
        typeId: typeId ?? this.typeId,
        userId: userId ?? this.userId,
        author: author ?? this.author,
        genre: genre ?? this.genre,
        album: album ?? this.album,
        year: year ?? this.year,
        duration: duration ?? this.duration,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory AdminSongsModel.fromJson(Map<String, dynamic> json) => AdminSongsModel(
    id: json["id"],
    name: json["name"],
    link: json["link"],
    typeId: json["typeId"],
    userId: json["userId"],
    author: json["author"],
    genre: json["genre"],
    album: json["album"],
    year: json["year"],
    duration: json["duration"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link,
    "typeId": typeId,
    "userId": userId,
    "author": author,
    "genre": genre,
    "album": album,
    "year": year,
    "duration": duration,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
  };
}
