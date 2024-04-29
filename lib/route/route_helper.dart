import 'package:food_app/details/popular_food_details.dart';
import 'package:food_app/details/recommended_food_details.dart';
import 'package:food_app/home/add_address_page.dart';
import 'package:food_app/home/cart_page.dart';
import 'package:food_app/home/home_page.dart';
import 'package:food_app/home/sign_in_page.dart';
import 'package:food_app/home/splash_page.dart';
import 'package:get/get.dart';

import '../home/main_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addressPage = "/address-page";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => addressPage;

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage(), transition: Transition.zoom),
    GetPage(
        name: popularFood,
        page: () {
          print("Popular food get called");
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetails(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: signIn,
        page: () {
          return const SignInPage();
        },
        transition: Transition.fade),
    GetPage(
        name: recommendedFood,
        page: () {
          print("Recommended food get called");
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addressPage,
        page: () {
          return const AddAddressPage();
        })
  ];
}
