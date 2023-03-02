
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/data/api_client.dart';
import 'package:food_app/repository/cart_repository.dart';
import 'package:food_app/repository/popular_product_repository.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../controller/recommended_product_controller.dart';
import '../repository/recommended_product_repo.dart';

Future <void> init()async {
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repository
  Get.lazyPut(() => PopularProductRepository(apiClient:Get.find()));
  Get.lazyPut(() => RecommendedProductRepository(apiClient:Get.find()));
  Get.lazyPut(() => CartRepository());

  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepository:Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepository:Get.find()));
  Get.lazyPut(() => CartController(cartRepository: Get.find()));
}