// To parse this JSON data, do
//
//     final withdrawListDataModel = withdrawListDataModelFromJson(jsonString);

import 'dart:convert';

WithdrawListDataModel withdrawListDataModelFromJson(String str) => WithdrawListDataModel.fromJson(json.decode(str));

String withdrawListDataModelToJson(WithdrawListDataModel data) => json.encode(data.toJson());

class WithdrawListDataModel {
    WithdrawListDataModel({
        this.status,
        this.data,
    });

    bool status;
    Data data;

    factory WithdrawListDataModel.fromJson(Map<String, dynamic> json) => WithdrawListDataModel(
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
        this.totalSaving,
        this.totalCurrent,
        this.total,
        this.pagResults,
        this.id,
        this.totalWithdraw,
    });

    List<dynamic> results;
    String headingTitle;
    String hrefAddWithdraw;
    String totalSaving;
    String totalCurrent;
    String total;
    PagResults pagResults;
    String id;
    String totalWithdraw;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        results: List<dynamic>.from(json["results"].map((x) => x)),
        headingTitle: json["heading_title"],
        hrefAddWithdraw: json["href_add_withdraw"],
        totalSaving: json["total_saving"],
        totalCurrent: json["total_current"],
        total: json["total"],
        pagResults: PagResults.fromJson(json["pag_results"]),
        id: json["id"],
        totalWithdraw: json["total_withdraw"],
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x)),
        "heading_title": headingTitle,
        "href_add_withdraw": hrefAddWithdraw,
        "total_saving": totalSaving,
        "total_current": totalCurrent,
        "total": total,
        "pag_results": pagResults.toJson(),
        "id": id,
        "total_withdraw": totalWithdraw,
    };
}

class PagResults {
    PagResults({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    int currentPage;
    List<dynamic> data;
    String firstPageUrl;
    dynamic from;
    int lastPage;
    String lastPageUrl;
    dynamic nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    dynamic to;
    int total;

    factory PagResults.fromJson(Map<String, dynamic> json) => PagResults(
        currentPage: json["current_page"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x)),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}
