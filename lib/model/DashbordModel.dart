// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromJson(jsonString);

import 'dart:convert';

DashBoardModel dashBoardModelFromJson(String str) => DashBoardModel.fromJson(json.decode(str));

String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());

class DashBoardModel {
  DashBoardModel({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
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
    this.serverTime,
    this.createdAt,
    this.paymentDate,
    this.currentDate,
    this.noOfWeek,
    this.days,
    this.hours,
    this.minutes,
    this.totalMembersThisWeek,
    this.totalMembersLastWeek,
    this.totalMemberOf15,
    this.countryName,
    this.packageName,
    this.packageMaxWorth,
    this.packageAlternateCash,
    this.packageAmount,
    this.packageImage,
    this.rank,
    this.rankImage,
    this.nextRank,
    this.nextRankImage,
    this.nextTotalMember,
    this.memberLeftForNextRank,
    this.image,
    this.name,
    this.username,
    this.email,
    this.mobile,
    this.isParent,
    this.agentType,
    this.myReferalUrl,
    this.childs,
    this.totalSaving,
    this.totalCurrent,
    this.totalEarning,
    // this.saving,
    this.current,
    this.points,
    this.width,
    this.totalMembers,
    this.personalSponsers,
    this.totalMemberLeft,
    this.totalMembersInPercentage,
    this.youNeed,
    this.pbv,
    this.tbv,
    this.personalSponser,
    this.totalTeamMember,
    this.totalMemberLeftForProperty,
    this.commissionVault,
    this.propertyVault,
    this.propertyRewardProgress,
    this.propertyValueIn3Year,
    this.alternateCashReward,
  });

  DateTime serverTime;
  String createdAt;
  DateTime paymentDate;
  DateTime currentDate;
  int noOfWeek;
  int days;
  String hours;
  String minutes;
  int totalMembersThisWeek;
  int totalMembersLastWeek;
  int totalMemberOf15;
  String countryName;
  String packageName;
  String packageMaxWorth;
  String packageAlternateCash;
  String packageAmount;
  String packageImage;
  String rank;
  String rankImage;
  String nextRank;
  String nextRankImage;
  int nextTotalMember;
  int memberLeftForNextRank;
  String image;
  String name;
  String username;
  String email;
  String mobile;
  bool isParent;
  String agentType;
  String myReferalUrl;
  int childs;
  String totalSaving;
  String totalCurrent;
  String totalEarning;
  // String saving;
  var current;
  int points;
  int width;
  int totalMembers;
  int personalSponsers;
  int totalMemberLeft;
  double totalMembersInPercentage;
  int youNeed;
  int pbv;
  int tbv;
  int personalSponser;
  int totalTeamMember;
  int totalMemberLeftForProperty;
  String commissionVault;
  String propertyVault;
  double propertyRewardProgress;
  String propertyValueIn3Year;
  String alternateCashReward;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    serverTime: DateTime.parse(json["server_time"]),
    createdAt: json["created_at"],
    paymentDate: DateTime.parse(json["payment_date"]),
    currentDate: DateTime.parse(json["current_date"]),
    noOfWeek: json["no_of_week"],
    days: json["days"],
    hours: json["hours"],
    minutes: json["minutes"],
    totalMembersThisWeek: json["total_members_this_week"],
    totalMembersLastWeek: json["total_members_last_week"],
    totalMemberOf15: json["total_member_of_15"],
    countryName: json["country_name"],
    packageName: json["package_name"],
    packageMaxWorth: json["package_max_worth"],
    packageAlternateCash: json["package_alternate_cash"],
    packageAmount: json["package_amount"],
    packageImage: json["package_image"],
    rank: json["rank"],
    rankImage: json["rank_image"],
    nextRank: json["next_rank"],
    nextRankImage: json["next_rank_image"],
    nextTotalMember: json["next_total_member"],
    memberLeftForNextRank: json["member_left_for_next_rank"],
    image: json["image"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    isParent: json["is_parent"],
    agentType: json["agent_type"],
    myReferalUrl: json["my_referal_url"],
    childs: json["childs"],
    totalSaving: json["total_saving"],
    totalCurrent: json["total_current"],
    totalEarning: json["total_earning"],
    // saving: json["saving"],
    current: json["current"],
    points: json["points"],
    width: json["width"],
    totalMembers: json["total_members"],
    personalSponsers: json["personal_sponsers"],
    totalMemberLeft: json["total_member_left"],
    totalMembersInPercentage: json["total_members_in_percentage"].toDouble(),
    youNeed: json["you_need"],
    pbv: json["pbv"],
    tbv: json["tbv"],
    personalSponser: json["personal_sponser"],
    totalTeamMember: json["total_team_member"],
    totalMemberLeftForProperty: json["total_member_left_for_property"],
    commissionVault: json["commission_vault"],
    propertyVault: json["property_vault"],
    propertyRewardProgress: json["property_reward_progress"].toDouble(),
    propertyValueIn3Year: json["property_value_in_3_year"],
    alternateCashReward: json["alternate_cash_reward"],
  );

  Map<String, dynamic> toJson() => {
    "server_time": serverTime.toIso8601String(),
    "created_at": createdAt,
    "payment_date": paymentDate.toIso8601String(),
    "current_date": currentDate.toIso8601String(),
    "no_of_week": noOfWeek,
    "days": days,
    "hours": hours,
    "minutes": minutes,
    "total_members_this_week": totalMembersThisWeek,
    "total_members_last_week": totalMembersLastWeek,
    "total_member_of_15": totalMemberOf15,
    "country_name": countryName,
    "package_name": packageName,
    "package_max_worth": packageMaxWorth,
    "package_alternate_cash": packageAlternateCash,
    "package_amount": packageAmount,
    "package_image": packageImage,
    "rank": rank,
    "rank_image": rankImage,
    "next_rank": nextRank,
    "next_rank_image": nextRankImage,
    "next_total_member": nextTotalMember,
    "member_left_for_next_rank": memberLeftForNextRank,
    "image": image,
    "name": name,
    "username": username,
    "email": email,
    "mobile": mobile,
    "is_parent": isParent,
    "agent_type": agentType,
    "my_referal_url": myReferalUrl,
    "childs": childs,
    "total_saving": totalSaving,
    "total_current": totalCurrent,
    "total_earning": totalEarning,
    // "saving": saving,
    "current": current,
    "points": points,
    "width": width,
    "total_members": totalMembers,
    "personal_sponsers": personalSponsers,
    "total_member_left": totalMemberLeft,
    "total_members_in_percentage": totalMembersInPercentage,
    "you_need": youNeed,
    "pbv": pbv,
    "tbv": tbv,
    "personal_sponser": personalSponser,
    "total_team_member": totalTeamMember,
    "total_member_left_for_property": totalMemberLeftForProperty,
    "commission_vault": commissionVault,
    "property_vault": propertyVault,
    "property_reward_progress": propertyRewardProgress,
    "property_value_in_3_year": propertyValueIn3Year,
    "alternate_cash_reward": alternateCashReward,
  };
}
