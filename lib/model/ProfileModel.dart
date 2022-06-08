// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.referral,
    this.image,
    this.gender,
     this.dob,
    this.birthPlace,
    this.countryOfBirth,
    this.isParent,
    this.sourceOfSignup,
    this.countryBirthName,
    this.address,
    this.zipcode,
    this.city,
    this.countryId,
    this.isDocVerified,
    this.addressCountryName,
     this.passportExpire,
    this.passportNo,
    this.personalFilename,
    this.countries,
    this.hrefProfileEdit,
    this.hrefUpdateBirthday,
    this.hrefUpdatePassport,
    this.hrefUpdateAddress,
    this.share,
    this.myReferalUrl,
    this.action,
    this.uploadDocsHref,
    this.isPinSet,
  });

  String firstName;
  String lastName;
  String mobile;
  String email;
  String referral;
  String image;
  String gender;
  String dob;
  String birthPlace;
  int countryOfBirth;
  bool isParent;
  String sourceOfSignup;
  String countryBirthName;
  String address;
  String zipcode;
  String city;
  int countryId;
  int isDocVerified;
  String addressCountryName;
  String passportExpire;
  String passportNo;
  String personalFilename;
  List<Country> countries;
  String hrefProfileEdit;
  String hrefUpdateBirthday;
  String hrefUpdatePassport;
  String hrefUpdateAddress;
  String share;
  String myReferalUrl;
  String action;
  String uploadDocsHref;
  bool isPinSet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    email: json["email"],
    referral: json["referral"],
    image: json["image"],
    gender: json["gender"],
    dob: json["dob"],
    birthPlace: json["birth_place"],
    countryOfBirth: json["country_of_birth"],
    isParent: json["is_parent"],
    sourceOfSignup: json["source_of_signup"],
    countryBirthName: json["country_birth_name"],
    address: json["address"],
    zipcode: json["zipcode"],
    city: json["city"],
    countryId: json["country_id"],
    isDocVerified: json["is_doc_verified"],
    addressCountryName: json["address_country_name"],
    passportExpire: json["passport_expire"],
    passportNo: json["passport_no"],
    personalFilename: json["personal_filename"],
    countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
    hrefProfileEdit: json["href_profile_edit"],
    hrefUpdateBirthday: json["href_update_birthday"],
    hrefUpdatePassport: json["href_update_passport"],
    hrefUpdateAddress: json["href_update_address"],
    share: json["share"],
    myReferalUrl: json["my_referal_url"],
    action: json["action"],
    uploadDocsHref: json["upload_docs_href"],
    isPinSet: json["is_pin_set"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "email": email,
    "referral": referral,
    "image": image,
    "gender": gender,
    "dob": dob,
    "birth_place": birthPlace,
    "country_of_birth": countryOfBirth,
    "is_parent": isParent,
    "source_of_signup": sourceOfSignup,
    "country_birth_name": countryBirthName,
    "address": address,
    "zipcode": zipcode,
    "city": city,
    "country_id": countryId,
    "is_doc_verified": isDocVerified,
    "address_country_name": addressCountryName,
    "passport_expire": passportExpire,
    "passport_no": passportNo,
    "personal_filename": personalFilename,
    "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
    "href_profile_edit": hrefProfileEdit,
    "href_update_birthday": hrefUpdateBirthday,
    "href_update_passport": hrefUpdatePassport,
    "href_update_address": hrefUpdateAddress,
    "share": share,
    "my_referal_url": myReferalUrl,
    "action": action,
    "upload_docs_href": uploadDocsHref,
    "is_pin_set": isPinSet,
  };
}

class Country {
  Country({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
