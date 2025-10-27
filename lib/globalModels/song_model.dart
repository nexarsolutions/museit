import 'package:get/get.dart';

class SongResponseModel {
  int? statusCode;
  String? message;
  SongResponseData? response;

  SongResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  SongResponseModel copyWith({
    int? statusCode,
    String? message,
    SongResponseData? response,
  }) =>
      SongResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory SongResponseModel.fromJson(Map<String, dynamic> json) =>
      SongResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        response: json["response"] == null
            ? null
            : SongResponseData.fromJson(json["response"]),
      );
}

class SongResponseData {
  int? count;
  List<SongModel>? songs;

  SongResponseData({
    this.count,
    this.songs,
  });

  SongResponseData copyWith({
    int? count,
    List<SongModel>? songs,
  }) =>
      SongResponseData(
        count: count ?? this.count,
        songs: songs ?? this.songs,
      );

  factory SongResponseData.fromJson(Map<String, dynamic> json) =>
      SongResponseData(
        count: json["count"],
        songs: json["rows"] == null
            ? []
            : List<SongModel>.from(
                json["rows"]!.map((x) => SongModel.fromJson(x))),
      );
}

class SongModel {
  // int? id;
  String? name;
  String? link;

  // double? price;
  // String? image;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  // RxBool isBuy;
  int? typeId;

  // PaidSongModel? paidSong;

  SongModel({
    // this.id,
    this.name,
    this.link,
    // this.price,
    // this.image,
    // this.createdAt,
    // this.updatedAt,
    this.typeId,
    // RxBool? isBuy,
    // this.paidSong
  }) /*: isBuy = isBuy ?? RxBool(false)*/;

  SongModel.copyWith(SongModel other)
      :
        // id = other.id,
        name = other.name,
        link = other.link,

        // price = other.price,
        // image = other.image,
        // createdAt = other.createdAt,
        // updatedAt = other.updatedAt,
        // isBuy = RxBool(other.isBuy.value),
        typeId = other.typeId

  // paidSong = other.paidSong != null
  //     ? PaidSongModel.copyWith(other.paidSong!)
  //     : null
  ;

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        // id: json["id"],
        name: json["name"],
        link: json["link"],
        // price: json["price"],
        // image: json["image"],
        typeId: json["typeId"],
        // createdAt: json["createdAt"] == null
        //     ? null
        //     : DateTime.parse(json["createdAt"]),
        // updatedAt: json["updatedAt"] == null
        //     ? null
        //     : DateTime.parse(json["updatedAt"]),
        // isBuy: RxBool(json['isBuy'] ?? false),
        // paidSong: json['PaidSongs'] == null
        //     ? null
        //     : PaidSongModel.fromJson(json['PaidSongs']),
      );

  Map<String, dynamic> toJson() => {
        "typeId": typeId,
        "name": name,
        "link": link,
      };

  void clear() {
    // isBuy.value = false;
    // id = null;
    name = null;
    link = null;
    // price = null;
    // image = null;
    // createdAt = null;
    // updatedAt = null;
    typeId = null;
  }
}

/*class PaidSongModel {
  int? id;
  double? price;
  int? typeId;
  String? image;
  String? name;
  String? link;
  DateTime? createdAt;

  PaidSongModel({
    this.id,
    this.price,
    this.typeId,
    this.image,
    this.name,
    this.link,
    this.createdAt,
  });

  PaidSongModel.copyWith(PaidSongModel other)
      : id = other.id,
        price = other.price,
        typeId = other.typeId,
        image = other.image,
        name = other.name,
        link = other.link,
        createdAt = other.createdAt;

  factory PaidSongModel.fromJson(Map<String, dynamic> json) => PaidSongModel(
        id: json["id"],
        price: json["price"]?.toDouble(),
        typeId: json["typeId"],
        image: json["image"],
        name: json["name"],
        link: json["link"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "typeId": typeId,
        "image": image,
        "name": name,
        "link": link,
        "createdAt": createdAt?.toIso8601String(),
      };
}*/
