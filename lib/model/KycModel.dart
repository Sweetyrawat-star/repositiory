// To parse this JSON data, do
//
//     final getKycModel = getKycModelFromJson(jsonString);

import 'dart:convert';

GetKycModel getKycModelFromJson(String str) => GetKycModel.fromJson(json.decode(str));

String getKycModelToJson(GetKycModel data) => json.encode(data.toJson());

class GetKycModel {
    GetKycModel({
        this.status,
        this.data,
    });

    bool status;
    Data data;

    factory GetKycModel.fromJson(Map<String, dynamic> json) => GetKycModel(
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
        this.buttons,
        this.isDocVerified,
        this.isDocVerifiedStatus,
        this.isParent,
        this.sourceOfSignup,
        this.countryBirthName,
        this.address,
        this.zipcode,
        this.city,
        this.countryId,
        this.addressCountryName,
        this.passportExpire,
        this.passportNo,
        this.personalFileType,
        this.addressFileType,
        this.personalFilename,
        this.personalFilename2,
        this.addressFile1,
        this.addressFile2,
        this.countries,
        this.hrefProfileEdit,
        this.hrefUpdateBirthday,
        this.hrefUpdatePassport,
        this.hrefUpdateAddress,
        this.share,
        this.myReferalUrl,
        this.action,
        this.uploadDocsHref,
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
    List<Button> buttons;
    int isDocVerified;
    String isDocVerifiedStatus;
    bool isParent;
    String sourceOfSignup;
    String countryBirthName;
    String address;
    String zipcode;
    String city;
    int countryId;
    String addressCountryName;
    String passportExpire;
    String passportNo;
    String personalFileType;
    String addressFileType;
    String personalFilename;
    String personalFilename2;
    String addressFile1;
    AddressFile2 addressFile2;
    List<Country> countries;
    String hrefProfileEdit;
    String hrefUpdateBirthday;
    String hrefUpdatePassport;
    String hrefUpdateAddress;
    String share;
    String myReferalUrl;
    String action;
    String uploadDocsHref;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        email: json["email"],
        referral: json["referral"],
        image: json["image"],
        gender: json["gender"],
       
        birthPlace: json["birth_place"],
        countryOfBirth: json["country_of_birth"],
        buttons: List<Button>.from(json["buttons"].map((x) => Button.fromJson(x))),
        isDocVerified: json["is_doc_verified"],
        isDocVerifiedStatus: json["is_doc_verified_status"],
        isParent: json["is_parent"],
        sourceOfSignup: json["source_of_signup"],
        countryBirthName: json["country_birth_name"],
        address: json["address"],
        zipcode: json["zipcode"],
        city: json["city"],
        countryId: json["country_id"],
        addressCountryName: json["address_country_name"],
      
        passportNo: json["passport_no"],
        personalFileType: json["personal_file_type"],
        addressFileType: json["address_file_type"],
        personalFilename: json["personal_filename"],
        personalFilename2: json["personal_filename_2"],
        addressFile1: json["address_file_1"],
        addressFile2: AddressFile2.fromJson(json["address_file_2"]),
        countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
        hrefProfileEdit: json["href_profile_edit"],
        hrefUpdateBirthday: json["href_update_birthday"],
        hrefUpdatePassport: json["href_update_passport"],
        hrefUpdateAddress: json["href_update_address"],
        share: json["share"],
        myReferalUrl: json["my_referal_url"],
        action: json["action"],
        uploadDocsHref: json["upload_docs_href"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "email": email,
        "referral": referral,
        "image": image,
        "gender": gender,
       
        "birth_place": birthPlace,
        "country_of_birth": countryOfBirth,
        "buttons": List<dynamic>.from(buttons.map((x) => x.toJson())),
        "is_doc_verified": isDocVerified,
        "is_doc_verified_status": isDocVerifiedStatus,
        "is_parent": isParent,
        "source_of_signup": sourceOfSignup,
        "country_birth_name": countryBirthName,
        "address": address,
        "zipcode": zipcode,
        "city": city,
        "country_id": countryId,
        "address_country_name": addressCountryName,
      
        "passport_no": passportNo,
        "personal_file_type": personalFileType,
        "address_file_type": addressFileType,
        "personal_filename": personalFilename,
        "personal_filename_2": personalFilename2,
        "address_file_1": addressFile1,
        "address_file_2": addressFile2.toJson(),
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
        "href_profile_edit": hrefProfileEdit,
        "href_update_birthday": hrefUpdateBirthday,
        "href_update_passport": hrefUpdatePassport,
        "href_update_address": hrefUpdateAddress,
        "share": share,
        "my_referal_url": myReferalUrl,
        "action": action,
        "upload_docs_href": uploadDocsHref,
    };
}

class AddressFile2 {
    AddressFile2();

    factory AddressFile2.fromJson(Map<String, dynamic> json) => AddressFile2(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Button {
    Button({
        this.name,
        this.href,
    });

    String name;
    String href;

    factory Button.fromJson(Map<String, dynamic> json) => Button(
        name: json["name"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "href": href,
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
