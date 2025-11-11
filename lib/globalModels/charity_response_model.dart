class CharityResponseModel {
  int? statusCode;
  CharityResponseData? response;

  CharityResponseModel({
    this.statusCode,
    this.response,
  });

  CharityResponseModel copyWith({
    int? statusCode,
    CharityResponseData? response,
  }) =>
      CharityResponseModel(
        statusCode: statusCode ?? this.statusCode,
        response: response ?? this.response,
      );

  factory CharityResponseModel.fromJson(Map<String, dynamic> json) => CharityResponseModel(
    statusCode: json["statusCode"],
    response: json["response"] == null ? null : CharityResponseData.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "response": response?.toJson(),
  };
}

class CharityResponseData {
  int? count;
  List<CharityUserModel>? rows;

  CharityResponseData({
    this.count,
    this.rows,
  });

  CharityResponseData copyWith({
    int? count,
    List<CharityUserModel>? rows,
  }) =>
      CharityResponseData(
        count: count ?? this.count,
        rows: rows ?? this.rows,
      );

  factory CharityResponseData.fromJson(Map<String, dynamic> json) => CharityResponseData(
    count: json["count"],
    rows: json["rows"] == null ? [] : List<CharityUserModel>.from(json["rows"]!.map((x) => CharityUserModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "rows": rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toJson())),
  };
}

class CharityUserModel {
  int? id;
  String? organtization;
  String? address;
  CharityUser? user;

  CharityUserModel({
    this.id,
    this.organtization,
    this.address,
    this.user,
  });

  CharityUserModel copyWith({
    int? id,
    String? organtization,
    String? address,
    CharityUser? user,
  }) =>
      CharityUserModel(
        id: id ?? this.id,
        organtization: organtization ?? this.organtization,
        address: address ?? this.address,
        user: user ?? this.user,
      );

  factory CharityUserModel.fromJson(Map<String, dynamic> json) => CharityUserModel(
    id: json["id"],
    organtization: json["organtization"],
    address: json["address"],
    user: json["User"] == null ? null : CharityUser.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "organtization": organtization,
    "address": address,
    "User": user?.toJson(),
  };
}

class CharityUser {
  int? id;
  String? username;
  String? profile;

  CharityUser({
    this.id,
    this.username,
    this.profile,
  });

  CharityUser copyWith({
    int? id,
    String? username,
    dynamic profile,
  }) =>
      CharityUser(
        id: id ?? this.id,
        username: username ?? this.username,
        profile: profile ?? this.profile,
      );

  factory CharityUser.fromJson(Map<String, dynamic> json) => CharityUser(
    id: json["id"],
    username: json["username"],
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "profile": profile,
  };
}
