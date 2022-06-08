// To parse this JSON data, do
//
//     final getBanner = getBannerFromJson(jsonString);

import 'dart:convert';

GetBanner getBannerFromJson(String str) => GetBanner.fromJson(json.decode(str));

String getBannerToJson(GetBanner data) => json.encode(data.toJson());

class GetBanner {
  GetBanner({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory GetBanner.fromJson(Map<String, dynamic> json) => GetBanner(
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
    this.banners,
  });

  List<Banner> banners;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
  };
}

class Banner {
  Banner({
    this.image,
    this.name,
  });

  String image;
  dynamic name;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    image: json["image"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name,
  };
}
