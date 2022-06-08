// To parse this JSON data, do
//
//     final myPackageModel = myPackageModelFromJson(jsonString);

import 'dart:convert';

MyPackageModel myPackageModelFromJson(String str) => MyPackageModel.fromJson(json.decode(str));

String myPackageModelToJson(MyPackageModel data) => json.encode(data.toJson());

class MyPackageModel {
  MyPackageModel({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory MyPackageModel.fromJson(Map<String, dynamic> json) => MyPackageModel(
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
    this.packageName,
    this.packageImage,
    this.packageAmount,
    this.packageDate,
    this.packageTime,
    this.description,
    this.paymentMethod,
  });

  String packageName;
  String packageImage;
  String packageAmount;
  DateTime packageDate;
  String packageTime;
  String description;
  dynamic paymentMethod;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    packageName: json["package_name"],
    packageImage: json["package_image"],
    packageAmount: json["package_amount"],
    packageDate: DateTime.parse(json["package_date"]),
    packageTime: json["package_time"],
    description: json["description"],
    paymentMethod: json["payment_method"],
  );

  Map<String, dynamic> toJson() => {
    "package_name": packageName,
    "package_image": packageImage,
    "package_amount": packageAmount,
    "package_date": "${packageDate.year.toString().padLeft(4, '0')}-${packageDate.month.toString().padLeft(2, '0')}-${packageDate.day.toString().padLeft(2, '0')}",
    "package_time": packageTime,
    "description": description,
    "payment_method": paymentMethod,
  };
}
