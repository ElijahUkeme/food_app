import 'dart:convert';

import 'package:food_app/data/api_client.dart';
import 'package:food_app/model/address_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

class LocationRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepository(
      {required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOLOCATION_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? "";
  }

  Future<Response> saveUserAddress(AddressModel addressModel) async {
    return await apiClient.post(
        AppConstants.SAVE_USER_ADDRESS_URI, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ALL_ADDRESS_URI);
  }

  Future<bool> saveUserAddressToLocalStorage(AddressModel addressModel) async {
    return await sharedPreferences.setString(
        AppConstants.USER_ADDRESS, jsonEncode(addressModel.toJson()));
  }

  void clearUserAddress() {
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
  }
}
