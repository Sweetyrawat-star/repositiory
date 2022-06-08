// To parse this JSON data, do
//
//     final indirectDistributeModel = indirectDistributeModelFromJson(jsonString);

import 'dart:convert';

IndirectDistributeModel indirectDistributeModelFromJson(String str) => IndirectDistributeModel.fromJson(json.decode(str));

String indirectDistributeModelToJson(IndirectDistributeModel data) => json.encode(data.toJson());

class IndirectDistributeModel {
  IndirectDistributeModel({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory IndirectDistributeModel.fromJson(Map<String, dynamic> json) => IndirectDistributeModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.email,
    this.username,
    this.mobile,
    this.agentType,
    this.sourceOfSignup,
    this.isDocVerified,
    this.address,
    this.sponserId,
  });

  int id;
  String name;
  String email;
  String username;
  String mobile;
  String agentType;
  String sourceOfSignup;
  String isDocVerified;
  String address;
  String sponserId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
    mobile: json["mobile"],
    agentType: json["agent_type"],
    sourceOfSignup: json["source_of_signup"],
    isDocVerified: json["is_doc_verified"],
    address: json["address"],
    sponserId: json["sponser_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "username": username,
    "mobile": mobile,
    "agent_type": agentType,
    "source_of_signup": sourceOfSignup,
    "is_doc_verified": isDocVerified,
    "address": address,
    "sponser_id": sponserId,
  };
}
