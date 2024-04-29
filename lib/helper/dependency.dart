import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/customer_controller.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/data/api_client.dart';
import 'package:food_app/repository/auth_repository.dart';
import 'package:food_app/repository/cart_repository.dart';
import 'package:food_app/repository/customer_repository.dart';
import 'package:food_app/repository/popular_product_repository.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/location_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../repository/location_repository.dart';
import '../repository/recommended_product_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repository
  Get.lazyPut(() => PopularProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CustomerRepository(apiClient: Get.find()));
  Get.lazyPut(() =>
      LocationRepository(apiClient: Get.find(), sharedPreferences: Get.find()));

  //controller
  Get.lazyPut(() => AuthController(authRepository: Get.find()));
  Get.lazyPut(
      () => PopularProductController(popularProductRepository: Get.find()));
  Get.lazyPut(() =>
      RecommendedProductController(recommendedProductRepository: Get.find()));
  Get.lazyPut(() => CartController(cartRepository: Get.find()));
  Get.lazyPut(() => CustomerController(customerRepository: Get.find()));
  Get.lazyPut(() => LocationController(locationRepository: Get.find()));
}
