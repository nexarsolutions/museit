import 'package:musit/globalModels/user_model.dart';

class HealthSupportResponseModel {
  int? statusCode;
  String? message;
  HealthSupportResponseData? response;

  HealthSupportResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  HealthSupportResponseModel copyWith({
    int? statusCode,
    String? message,
    HealthSupportResponseData? response,
  }) =>
      HealthSupportResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory HealthSupportResponseModel.fromJson(Map<String, dynamic> json) =>
      HealthSupportResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        response: json["response"] == null
            ? null
            : HealthSupportResponseData.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "response": response?.toJson(),
      };
}

class HealthSupportResponseData {
  int? count;
  List<HealthSupportModel>? healthSupporters;

  HealthSupportResponseData({
    this.count,
    this.healthSupporters,
  });

  HealthSupportResponseData copyWith({
    int? count,
    List<HealthSupportModel>? healthSupporters,
  }) =>
      HealthSupportResponseData(
        count: count ?? this.count,
        healthSupporters: healthSupporters ?? this.healthSupporters,
      );

  factory HealthSupportResponseData.fromJson(Map<String, dynamic> json) =>
      HealthSupportResponseData(
        count: json["count"],
        healthSupporters: json["rows"] == null
            ? []
            : List<HealthSupportModel>.from(
                json["rows"]!.map((x) => HealthSupportModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": healthSupporters == null
            ? []
            : List<dynamic>.from(healthSupporters!.map((x) => x.toJson())),
      };
}

class HealthSupportModel {
  String? healthTypeName;
  int? id;
  int? userId;
  int? healthTypeId;
  String? disease;
  int? monthlyAidGoal;
  String? story;
  String? uploadProof;
  String? bankName;
  String? accountNumber;
  String? accountTitle;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  UserModel? user;

  HealthSupportModel({
    this.healthTypeName,
    this.id,
    this.userId,
    this.healthTypeId,
    this.disease,
    this.monthlyAidGoal,
    this.story,
    this.uploadProof,
    this.bankName,
    this.accountNumber,
    this.accountTitle,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
  });

  HealthSupportModel copyWith({
    String? healthTypeName,
    int? id,
    int? userId,
    int? healthTypeId,
    String? disease,
    int? monthlyAidGoal,
    String? story,
    String? uploadProof,
    String? bankName,
    String? accountNumber,
    String? accountTitle,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    UserModel? user,
  }) =>
      HealthSupportModel(
        healthTypeName: healthTypeName ?? this.healthTypeName,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        healthTypeId: healthTypeId ?? this.healthTypeId,
        disease: disease ?? this.disease,
        monthlyAidGoal: monthlyAidGoal ?? this.monthlyAidGoal,
        story: story ?? this.story,
        uploadProof: uploadProof ?? this.uploadProof,
        bankName: bankName ?? this.bankName,
        accountNumber: accountNumber ?? this.accountNumber,
        accountTitle: accountTitle ?? this.accountTitle,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        user: user ?? this.user,
      );

  factory HealthSupportModel.fromJson(Map<String, dynamic> json) =>
      HealthSupportModel(
        healthTypeName: json["healthTypeName"],
        id: json["id"],
        userId: json["userId"],
        healthTypeId: json["healthTypeId"],
        disease: json["disease"],
        monthlyAidGoal: json["monthlyAidGoal"],
        story: json["story"],
        uploadProof: json["uploadProof"],
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        accountTitle: json["accountTitle"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"] == null
            ? null
            : DateTime.parse(json["deletedAt"]),
        user: json["User"] == null ? null : UserModel.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "healthTypeName": healthTypeName,
        "id": id,
        "userId": userId,
        "healthTypeId": healthTypeId,
        "disease": disease,
        "monthlyAidGoal": monthlyAidGoal,
        "story": story,
        "uploadProof": uploadProof,
        "bankName": bankName,
        "accountNumber": accountNumber,
        "accountTitle": accountTitle,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": createdAt?.toIso8601String(),
        "User": user?.toSharedJson(),
      };
}
