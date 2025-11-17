class SongRecipientsResponseModel {
  int? statusCode;
  String? message;
  List<SongRecipientsResponseData>? response;

  SongRecipientsResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  SongRecipientsResponseModel copyWith({
    int? statusCode,
    String? message,
    List<SongRecipientsResponseData>? response,
  }) =>
      SongRecipientsResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory SongRecipientsResponseModel.fromJson(Map<String, dynamic> json) =>
      SongRecipientsResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        response: json["response"] == null
            ? []
            : List<SongRecipientsResponseData>.from(
                json["response"]!.map((x) => SongRecipientsResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class SongRecipientsResponseData {
  int? id;
  String? username;
  String? profile;
  String? email;

  SongRecipientsResponseData({
    this.id,
    this.username,
    this.profile,
    this.email,
  });

  SongRecipientsResponseData copyWith({
    int? id,
    String? username,
    String? profile,
    String? email,
  }) =>
      SongRecipientsResponseData(
        id: id ?? this.id,
        username: username ?? this.username,
        profile: profile ?? this.profile,
        email: email ?? this.email,
      );

  factory SongRecipientsResponseData.fromJson(Map<String, dynamic> json) => SongRecipientsResponseData(
        id: json["id"],
        username: json["username"],
        profile: json["profile"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profile": profile,
        "email": email,
      };
}
