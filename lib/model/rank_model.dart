// To parse this JSON data, do
//
//     final rankModel = rankModelFromJson(jsonString);

import 'dart:convert';

RankModel rankModelFromJson(String str) => RankModel.fromJson(json.decode(str));

String rankModelToJson(RankModel data) => json.encode(data.toJson());

class RankModel {
  RankModel({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory RankModel.fromJson(Map<String, dynamic> json) => RankModel(
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
    this.totalMembers,
    this.totalMemberLeftForNext,
    this.nextRank,
    this.nextRankImage,
    this.nextTotalMember,
    this.rankName,
    this.rankImage,
  });

  int totalMembers;
  int totalMemberLeftForNext;
  String nextRank;
  String nextRankImage;
  int nextTotalMember;
  String rankName;
  String rankImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalMembers: json["total_members"],
    totalMemberLeftForNext: json["total_member_left_for_next"],
    nextRank: json["next_rank"],
    nextRankImage: json["next_rank_image"],
    nextTotalMember: json["next_total_member"],
    rankName: json["rank_name"],
    rankImage: json["rank_image"],
  );

  Map<String, dynamic> toJson() => {
    "total_members": totalMembers,
    "total_member_left_for_next": totalMemberLeftForNext,
    "next_rank": nextRank,
    "next_rank_image": nextRankImage,
    "next_total_member": nextTotalMember,
    "rank_name": rankName,
    "rank_image": rankImage,
  };
}
