import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/customer_controller.dart';
import 'package:food_app/controller/location_controller.dart';
import 'package:food_app/model/address_model.dart';
import 'package:food_app/route/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  var addressController = TextEditingController();
  var contactPersonController = TextEditingController();
  var contactPersonNumberController = TextEditingController();
  late bool isUserLoggedIn;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = const LatLng(45.51563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _authController = Get.find<AuthController>();
    bool _isUserLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isUserLoggedIn) {
      Get.find<CustomerController>()
          .getUserInfo(_authController.getUserToken());
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>().saveUserAddressToLocalStorage(
            Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));

      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Address Page"),
          backgroundColor: Colors.greenAccent,
        ),
        body: GetBuilder<CustomerController>(builder: (customerController) {
          // if (customerController.customerModel != null &&
          //     contactPersonController.text.isEmpty) {
          //   contactPersonController.text =
          //       customerController.customerModel.name;
          //   contactPersonNumberController.text =
          //       customerController.customerModel.phone;
          // }
          return GetBuilder<LocationController>(builder: (locationController) {
            // addressController.text =
            //     '${locationController.placemark.name ?? ''}'
            //     '${locationController.placemark.locality ?? ''}'
            //     '${locationController.placemark.postalCode ?? ''}'
            //     '${locationController.placemark.country ?? ''}';
            if (Get.find<LocationController>().getUserAddress() != null) {
              addressController.text =
                  locationController.getUserAddress().address;
              contactPersonNumberController.text =
                  locationController.getUserAddress().contactPersonNumber!;
              contactPersonController.text =
                  locationController.getUserAddress().contactPerson!;
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(right: 5, left: 5, top: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(width: 2, color: Colors.greenAccent)),
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: _initialPosition, zoom: 17),
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          onCameraIdle: () {
                            locationController.updateLocation(
                                _cameraPosition, true);
                          },
                          onCameraMove: ((position) =>
                              _cameraPosition = position),
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setMapController(controller);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimension.width20, top: Dimension.height20),
                    child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                locationController.addressTypeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    locationController
                                        .setAddressTypeIndex(index);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimension.height20,
                                          vertical: Dimension.height10),
                                      margin: EdgeInsets.only(
                                          right: Dimension.height10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimension.height20 / 4),
                                          color: Theme.of(context).cardColor,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[200]!,
                                                spreadRadius: 1,
                                                blurRadius: 5),
                                          ]),
                                      child: Icon(
                                        index == 0
                                            ? Icons.home
                                            : index == 1
                                                ? Icons.work
                                                : Icons.location_on,
                                        color: locationController
                                                    .addressTypeIndex ==
                                                index
                                            ? Colors.greenAccent
                                            : Theme.of(context).disabledColor,
                                      )));
                            })),
                  ),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimension.width20),
                    child: BigTexts(text: "Delivery address"),
                  ),
                  SizedBox(
                    height: Dimension.height10,
                  ),
                  AppTextField(
                      textEditingController: addressController,
                      textHint: "Your Address",
                      icon: Icons.map),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  Stack(
                    children: [
                      Center(
                          child: Visibility(
                              visible: locationController.isLoading,
                              child: buildLoadingIndicator())),
                      Padding(
                        padding: EdgeInsets.only(left: Dimension.width20),
                        child: BigTexts(text: "Contact Name"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimension.height10,
                  ),
                  AppTextField(
                      textEditingController: contactPersonController,
                      textHint: "Your Name",
                      icon: Icons.person),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimension.width20),
                    child: BigTexts(text: "Contact phone"),
                  ),
                  SizedBox(
                    height: Dimension.height10,
                  ),
                  AppTextField(
                      textEditingController: contactPersonNumberController,
                      textHint: "Your Phone",
                      icon: Icons.phone),
                ],
              ),
            );
          });
        }),
        bottomNavigationBar:
            GetBuilder<LocationController>(builder: (locationController) {
          return Container(
            height: Dimension.height20 * 8,
            padding: EdgeInsets.only(
                top: Dimension.height30,
                bottom: Dimension.height30,
                left: Dimension.width20,
                right: Dimension.width20),
            decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.radius20 * 2),
                    topRight: Radius.circular(Dimension.radius20 * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimension.height20,
                      bottom: Dimension.height20,
                      left: Dimension.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius20),
                      color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    saveAddress();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimension.height20,
                        bottom: Dimension.height20,
                        left: Dimension.width20,
                        right: Dimension.width20),
                    child: BigTexts(
                      text: "Save Address",
                      color: Colors.white,
                      size: 26,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: Colors.greenAccent),
                  ),
                )
              ],
            ),
          );
        }));
  }

  void saveAddress() {
    var locationController = Get.find<LocationController>();
    if (addressController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Address Required");
      return;
    } else {
      AddressModel addressModel = AddressModel(
          addressType: locationController
              .addressTypeList[locationController.addressTypeIndex],
          contactPerson: contactPersonController.text,
          contactPersonNumber: contactPersonNumberController.text,
          address: addressController.text);
      locationController.saveAddress(addressModel).then((value) => {
            if (value.isSuccess)
              {
                Get.toNamed(RouteHelper.getInitial()),
              }
            else
              {Get.back()}
          });
    }
  }
}
