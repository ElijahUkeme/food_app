import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/model/address_model.dart';
import 'package:food_app/model/registration_response_model.dart';
import 'package:food_app/repository/location_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepository locationRepository;
  LocationController({required this.locationRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late Position _position;
  late Position _pickedPosition;
  Placemark _placemark = Placemark();
  Placemark _pickedPlaceMark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickedPlaceMark => _pickedPlaceMark;
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;
  List<AddressModel> get addressList => _addressList;
  List<String> _addressTypeList = ["Home", "Office", "Others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress = {};
  Map get getAddress => _getAddress;
  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updateLocation(CameraPosition cameraPosition, bool fromAddress) async {
    if (_updateAddressData) {
      _isLoading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              altitudeAccuracy: 1,
              heading: 1,
              headingAccuracy: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickedPosition = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              altitudeAccuracy: 1,
              heading: 1,
              headingAccuracy: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(LatLng(
              cameraPosition.target.latitude, cameraPosition.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickedPlaceMark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Unknown Location found";
    Response response = await locationRepository.getAddressFromGeocode(latLng);
    if (response.body["status"] == "OK") {
      _address = response.body['results'][0]['formatted_address'].toString();
      print(_address);
    } else {
      print("Error getting google map api");
    }
    update();
    return _address;
  }

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepository.getUserAddress());
    print("The first stage is $_getAddress");

    try {
      _addressModel = AddressModel.fromJson(_getAddress);
      print("The second stage is ${_addressModel.address}");
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<RegistrationResponseModel> saveAddress(
      AddressModel addressModel) async {
    _isLoading = true;
    update();
    Response response = await locationRepository.saveUserAddress(addressModel);
    late RegistrationResponseModel responseModel;
    if (response.statusCode == 201) {
      await getAllAddress();
      _isLoading = false;
      update();
      responseModel = RegistrationResponseModel(
          response.body["success"], response.body["message"]);
      print("The response is " + responseModel.message);
      showCustomSnackBar(response.body["message"], title: "Message");
      await saveUserAddressToLocalStorage(addressModel);
    } else {
      _isLoading = false;
      update();
      responseModel = RegistrationResponseModel(false, response.statusText!);
      print("The response is " + response.statusText!);
      showCustomSnackBar(response.statusText!, title: "Error");
    }
    _isLoading = false;
    return responseModel;
  }

  Future<void> getAllAddress() async {
    Response response = await locationRepository.getAllAddress();
    if (response == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
        print("Server addresses are $_addressList");
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  saveUserAddressToLocalStorage(AddressModel addressModel) {
    return locationRepository.saveUserAddressToLocalStorage(addressModel);
  }

  void clearAllAddresses() {
    _addressList = [];
    _allAddressList = [];
    locationRepository.clearUserAddress();
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepository.getUserAddress();
  }
}
