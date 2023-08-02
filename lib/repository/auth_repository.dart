import 'package:flutter/material.dart';
import 'package:food_app/data/api_client.dart';
import 'package:food_app/model/sign_up_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepository({
    required this.apiClient,required this.sharedPreferences
});

  Future <Response> registration(SignUpModel signUpModel) async {
    return await apiClient.postData(AppConstants.CUSTOMER_REGISTRATION_URI, signUpModel.toJson());
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  bool userLoggedIn() {
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future <Response> login(String email,String password) async {
    return await apiClient.postData(AppConstants.CUSTOMER_LOGIN_URI, {"email":email,"password":password});
  }

  Future<bool>saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }
  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token = "";
    apiClient.updateHeader("");

    return true;
  }

  String retrieveUserToken(){
    return sharedPreferences.getString(AppConstants.TOKEN).toString();
  }
}