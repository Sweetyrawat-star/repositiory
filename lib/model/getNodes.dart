// To parse this JSON data, do
//
//     final getnodes = getnodesFromJson(jsonString);

import 'dart:convert';

Getnodes getnodesFromJson(String str) => Getnodes.fromJson(json.decode(str));

String getnodesToJson(Getnodes data) => json.encode(data.toJson());

class Getnodes {
    Getnodes({
        this.status,
        this.data,
    });

    bool status;
    String data;

    factory Getnodes.fromJson(Map<String, dynamic> json) => Getnodes(
        status: json["status"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
    };
}