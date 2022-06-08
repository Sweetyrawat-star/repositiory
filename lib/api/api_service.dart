import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/Login.dart';
import 'package:swiftasset/model/ApprovedModel.dart';
import 'package:swiftasset/model/DashbordModel.dart';
import 'package:swiftasset/model/GetBannerModel.dart';
import 'package:swiftasset/model/KycModel.dart';
import 'package:swiftasset/model/MyPackageModel.dart';
import 'package:swiftasset/model/Payment.dart';
import 'package:swiftasset/model/ProfileModel.dart';
import 'package:swiftasset/model/PropertyVaultModel.dart';
import 'package:swiftasset/model/commission_vault_model.dart';
import 'dart:convert';
import 'package:swiftasset/model/rank_model.dart';
import 'package:swiftasset/model/transaction_listModel.dart';
import 'package:swiftasset/model/withdawlistModel.dart';
import 'package:swiftasset/sharedpreference/store.dart';

class APIService {

   static Future<DashBoardModel> getDashBoard() async {
     try {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    final url = "http://dev.swiftassets.net/public/api/dashboard";
   
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': '$header',
    }
    );
    print(response);
    if (response.statusCode == 200) {
      final getProduct = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return DashBoardModel.fromJson(getProduct);
    } else {
    
    }
       
     } catch (e) {
         print("catch error$e");
     }
     return DashBoardModel();
   }
    static Future<CommissionVaultModel> getCommissionVault() async {
     try {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    final url = "http://dev.swiftassets.net/public/api/commission_vault";
   
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': '$header',
    }
    );
    print(response);
    if (response.statusCode == 200) {
      final getProduct = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return CommissionVaultModel.fromJson(getProduct);
    } else {
    
    }
       
     } catch (e) {
         print("catch error$e");
     }
     return CommissionVaultModel();
   }
    static Future<PropertyVaultModel> getPropertyVault() async {
     try {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    final url = "http://dev.swiftassets.net/public/api/property_vault";
   
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': '$header',
    }
    );
    print(response);
    if (response.statusCode == 200) {
      final getProduct = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return PropertyVaultModel.fromJson(getProduct);
    } else {
    
    }
       
     } catch (e) {
         print("catch error$e");
     }
     return PropertyVaultModel();
   }
    Future<GetKycModel> getKyc() async {
     try {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    final url = "http://dev.swiftassets.net/public/api/kyc";
   
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': '$header',
    }
    );
    print(response);
    if (response.statusCode == 200) {
      final getProduct = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return GetKycModel.fromJson(getProduct);
    } else {
    
    }
       
     } catch (e) {
         print("catch error$e");
     }
     return GetKycModel();
   }
  Future<GetWithdrawListModel> getWithdrawList() async {
     try {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    final url = "http://dev.swiftassets.net/public/api/withdraw/list";
   
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': '$header',
    }
    );
    print(response);
    if (response.statusCode == 200) {
      final getProduct = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return GetWithdrawListModel.fromJson(getProduct);
    } else {
    
    }
       
     } catch (e) {
         print("catch error$e");
     }
     return GetWithdrawListModel();
   }


  static Future<GetBanner> getBanner() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      print("token" + "$store1");
      var header = "Bearer $store1";
      final url = "http://dev.swiftassets.net/public/api/get_banners";

      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Authorization': '$header',
      }
      );
      print(response);
      if (response.statusCode == 200) {
        final getProduct = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return GetBanner.fromJson(getProduct);
      } else {

      }

    } catch (e) {
      print("catch error$e");
    }
    return GetBanner();
  }
    Future<ApprovedModel> getApproved() async {
     try {
       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       store1 = sharedPreferences.getString("token");
       print("token" + "$store1");
       var header = "Bearer $store1";
       final url = "http://dev.swiftassets.net/public/api/withdraw/approved";

       final response = await http.get(url, headers: {
         "Content-Type": "application/json",
         'Authorization': '$header',
       }
       );
       print(response);
       if (response.statusCode == 200) {
         final getProduct = jsonDecode(response.body);
         print(response.statusCode);
         print(response.body);
         return ApprovedModel.fromJson(getProduct);
       } else {

       }

     } catch (e) {
       print("catch error$e");
     }
     return ApprovedModel();
   }

  

  static Future<MyPackageModel> getMyPackage() async {
     try{
       final url = "http://dev.swiftassets.net/public/api/package";
       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       store1 = sharedPreferences.getString("token");
       print("token" + "$store1");
       final response = await http.get(url, headers: {
         HttpHeaders.contentTypeHeader: "application/json",
         HttpHeaders.authorizationHeader: "Bearer $store1"
       });
       print(response);
       if (response.statusCode == 200) {
         final getProduct = jsonDecode(response.body);
         print(response.statusCode);
         print(response.body);
         return MyPackageModel.fromJson(getProduct);
       } else {
         throw Exception();
       }

     }catch(e){
       print("catch error$e");
     }
     return MyPackageModel();

  }

  static Future<PaymentModel> getPayment() async {
     try{
       final url = "http://dev.swiftassets.net/public/api/payment";
       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       store1 = sharedPreferences.getString("token");
       print("token" + "$store1");
       final response = await http.get(url, headers: {
         HttpHeaders.contentTypeHeader: "application/json",
         HttpHeaders.authorizationHeader: "Bearer $store1"
       });
       print(response);
       if (response.statusCode == 200) {
         final getProduct = jsonDecode(response.body);
         print(response.statusCode);
         print(response.body);
         return PaymentModel.fromJson(getProduct);
       } else {
         throw Exception();
       }

     }catch(e){
       print("catch error");
     }
     return PaymentModel();

  }
  static Future<TransactionListModel> getTransactionList() async {
    try{
      final url = "http://dev.swiftassets.net/public/api/transaction_list";
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      print("token" + "$store1");
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $store1"
      });
      print(response);
      if (response.statusCode == 200) {
        final getProduct = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return TransactionListModel.fromJson(getProduct);
      } else {
        throw Exception();
      }
    }catch(e){
      print("catch error$e");
    }
    return TransactionListModel();

  }
   
  static Future<ProfileModel> getCountry() async {
    try{
      final url = "http://dev.swiftassets.net/public/api/user";
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      print("token" + "$store1");
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $store1"
      });
      print(response);
      if (response.statusCode == 200) {
        final getProduct = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);

        return ProfileModel.fromJson(getProduct);
      } else {
        throw Exception();
      }

    }catch(e){
      print("catch error$e");

    }
    return ProfileModel();

  }


  static Future<RankModel> getRank() async {
    try{
      final url = "http://dev.swiftassets.net/public/api/rank";
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      print("token" + "$store1");
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $store1"
      });
      print(response);
      if (response.statusCode == 200) {
        final getProduct = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return RankModel.fromJson(getProduct);
      } else {
        throw Exception();
      }
    }catch(e){
      print("catch error$e");
    }
    return RankModel();

  }


   Future<ProfileModel> getProfile() async {
      try {
           SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    final url = "http://dev.swiftassets.net/public/api/user";
   
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': '$header',
    }
    );
    print(response);
    if (response.statusCode == 200) {
      final getProduct = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return ProfileModel.fromJson(getProduct);
    } else {
     
    }
      } catch (e) {
        print("catch error$e");
      }
    return ProfileModel();
  }
  static Future<void> onLogoutClicked(BuildContext context) async {
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      print("token" + "$store1");
      String url = "http://dev.swiftassets.net/public/api/logout";

      var jsonResponse;
      var response = await http.post(url, headers: {

      });
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print("response statusCode ${response.statusCode}");
        print("body$jsonResponse");
        if (jsonResponse != null) {
          var token2 = sharedPreferences.getString("token");
          print(token2);
          sharedPreferences.clear();
          Fluttertoast.showToast(
              msg: "LogOut Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue[200],
              textColor: Colors.black,
              fontSize: 16.0);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
        } else {
          print("Error");
          Fluttertoast.showToast(
              msg: "Something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 20,
              backgroundColor: Colors.blue[200],
              textColor: Colors.black,
              fontSize: 16.0);

        }
      }
    }catch(e){
      print("catch error $e");
    }
   }
}
