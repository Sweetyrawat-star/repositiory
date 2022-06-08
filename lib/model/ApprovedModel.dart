// To parse this JSON data, do
//
//     final approvedModel = approvedModelFromJson(jsonString);

import 'dart:convert';

ApprovedModel approvedModelFromJson(String str) => ApprovedModel.fromJson(json.decode(str));

String approvedModelToJson(ApprovedModel data) => json.encode(data.toJson());

class ApprovedModel {
    ApprovedModel({
        this.status,
        this.data,
    });

    bool status;
    Data data;

    factory ApprovedModel.fromJson(Map<String, dynamic> json) => ApprovedModel(
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
        this.totalSaving,
        this.totalCurrent,
        this.total,
        this.totalWithdraw,
    });

    List<Result> results;
    String totalSaving;
    String totalCurrent;
    String total;
    String totalWithdraw;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalSaving: json["total_saving"],
        totalCurrent: json["total_current"],
        total: json["total"],
        totalWithdraw: json["total_withdraw"],
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_saving": totalSaving,
        "total_current": totalCurrent,
        "total": total,
        "total_withdraw": totalWithdraw,
    };
}

class Result {
    Result({
        this.description,
        this.approveStatus,
        this.amount,
        this.paymentMethod,
    });

    String description;
    String approveStatus;
    String amount;
    String paymentMethod;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        description: json["description"],
        approveStatus: json["approve_status"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "approve_status": approveStatus,
        "amount": amount,
        "payment_method": paymentMethod,
    };
}
