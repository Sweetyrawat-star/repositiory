// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
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
    this.bankAccountNumber,
    this.bankCountry,
    this.accountHolderName,
    this.bankWithdrawAmount,
    this.bankName,
    this.bankAddress,
    this.bankSwiftCode,
    this.bankComment,
  });

  String bankAccountNumber;
  String bankCountry;
  String accountHolderName;
  dynamic bankWithdrawAmount;
  dynamic bankName;
  dynamic bankAddress;
  dynamic bankSwiftCode;
  dynamic bankComment;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bankAccountNumber: json["bank_account_number"],
    bankCountry: json["bank_country"],
    accountHolderName: json["account_holder_name"],
    bankWithdrawAmount: json["bank_withdraw_amount"],
    bankName: json["bank_name"],
    bankAddress: json["bank_address"],
    bankSwiftCode: json["bank_swift_code"],
    bankComment: json["bank_comment"],
  );

  Map<String, dynamic> toJson() => {
    "bank_account_number": bankAccountNumber,
    "bank_country": bankCountry,
    "account_holder_name": accountHolderName,
    "bank_withdraw_amount": bankWithdrawAmount,
    "bank_name": bankName,
    "bank_address": bankAddress,
    "bank_swift_code": bankSwiftCode,
    "bank_comment": bankComment,
  };
}
