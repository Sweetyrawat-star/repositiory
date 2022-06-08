// To parse this JSON data, do
//
//     final updatePin = updatePinFromJson(jsonString);

import 'dart:convert';

UpdatePin updatePinFromJson(String str) => UpdatePin.fromJson(json.decode(str));

String updatePinToJson(UpdatePin data) => json.encode(data.toJson());

class UpdatePin {
  UpdatePin({
    this.status,
    this.errors,
  });

  bool status;
  String errors;

  factory UpdatePin.fromJson(Map<String, dynamic> json) => UpdatePin(
    status: json["status"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errors": errors,
  };
}
