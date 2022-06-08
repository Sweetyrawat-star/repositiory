// To parse this JSON data, do
//
//     final resetPassword = resetPasswordFromJson(jsonString);

import 'dart:convert';

ResetPassword resetPasswordFromJson(String str) => ResetPassword.fromJson(json.decode(str));

String resetPasswordToJson(ResetPassword data) => json.encode(data.toJson());

class ResetPassword {
  ResetPassword({
    this.status,
    this.errors,
  });

  bool status;
  String errors;

  factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
    status: json["status"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errors": errors,
  };
}