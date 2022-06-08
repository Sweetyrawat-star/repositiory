// To parse this JSON data, do
//
//     final commissionVaultModel = commissionVaultModelFromJson(jsonString);

import 'dart:convert';

CommissionVaultModel commissionVaultModelFromJson(String str) => CommissionVaultModel.fromJson(json.decode(str));

String commissionVaultModelToJson(CommissionVaultModel data) => json.encode(data.toJson());

class CommissionVaultModel {
  CommissionVaultModel({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory CommissionVaultModel.fromJson(Map<String, dynamic> json) => CommissionVaultModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.results,
    this.headingTitle,
    this.hrefAddWithdraw,
    this.totalCommissionImage,
    this.totalSavingImage,
    this.totalSaving,
    this.totalCurrent,
  });

  List<Result> results;
  String headingTitle;
  String hrefAddWithdraw;
  String totalCommissionImage;
  String totalSavingImage;
  String totalSaving;
  String totalCurrent;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    headingTitle: json["heading_title"],
    hrefAddWithdraw: json["href_add_withdraw"],
    totalCommissionImage: json["total_commission_image"],
    totalSavingImage: json["total_saving_image"],
    totalSaving: json["total_saving"],
    totalCurrent: json["total_current"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "heading_title": headingTitle,
    "href_add_withdraw": hrefAddWithdraw,
    "total_commission_image": totalCommissionImage,
    "total_saving_image": totalSavingImage,
    "total_saving": totalSaving,
    "total_current": totalCurrent,
  };
}

class Result {
  Result({
    this.description,
    this.transactionType,
    this.amount,
    this.referTo,
  });

  String description;
  String transactionType;
  String amount;
  String referTo;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    description: json["description"],
    transactionType: json["transaction_type"],
    amount: json["amount"],
    referTo: json["refer_to"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "transaction_type": transactionType,
    "amount": amount,
    "refer_to": referTo,
  };
}
