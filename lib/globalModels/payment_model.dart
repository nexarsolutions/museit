class PaymentResponseModel {
  int? statusCode;
  String? message;
  PaymentResponseData? data;

  PaymentResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  PaymentResponseModel copyWith({
    int? statusCode,
    String? message,
    PaymentResponseData? data,
  }) =>
      PaymentResponseModel(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) => PaymentResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : PaymentResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class PaymentResponseData {
  Paypal? paypal;
  Donation? donation;
  Charity? charity;

  PaymentResponseData({
    this.paypal,
    this.donation,
    this.charity,
  });

  PaymentResponseData copyWith({
    Paypal? paypal,
    Donation? donation,
    Charity? charity,
  }) =>
      PaymentResponseData(
        paypal: paypal ?? this.paypal,
        donation: donation ?? this.donation,
        charity: charity ?? this.charity,
      );

  factory PaymentResponseData.fromJson(Map<String, dynamic> json) => PaymentResponseData(
    paypal: json["paypal"] == null ? null : Paypal.fromJson(json["paypal"]),
    donation: json["donation"] == null ? null : Donation.fromJson(json["donation"]),
    charity: json["charity"] == null ? null : Charity.fromJson(json["charity"]),
  );

  Map<String, dynamic> toJson() => {
    "paypal": paypal?.toJson(),
    "donation": donation?.toJson(),
    "charity": charity?.toJson(),
  };
}

class Charity {
  int? id;
  String? name;
  int? userId;

  Charity({
    this.id,
    this.name,
    this.userId,
  });

  Charity copyWith({
    int? id,
    String? name,
    int? userId,
  }) =>
      Charity(
        id: id ?? this.id,
        name: name ?? this.name,
        userId: userId ?? this.userId,
      );

  factory Charity.fromJson(Map<String, dynamic> json) => Charity(
    id: json["id"],
    name: json["name"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "userId": userId,
  };
}

class Donation {
  int? id;
  int? amount;
  String? currency;

  Donation({
    this.id,
    this.amount,
    this.currency,
  });

  Donation copyWith({
    int? id,
    int? amount,
    String? currency,
  }) =>
      Donation(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
    id: json["id"],
    amount: json["amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "currency": currency,
  };
}

class Paypal {
  String? orderId;
  String? approvalLink;
  String? status;

  Paypal({
    this.orderId,
    this.approvalLink,
    this.status,
  });

  Paypal copyWith({
    String? orderId,
    String? approvalLink,
    String? status,
  }) =>
      Paypal(
        orderId: orderId ?? this.orderId,
        approvalLink: approvalLink ?? this.approvalLink,
        status: status ?? this.status,
      );

  factory Paypal.fromJson(Map<String, dynamic> json) => Paypal(
    orderId: json["orderId"],
    approvalLink: json["approvalLink"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "approvalLink": approvalLink,
    "status": status,
  };
}
