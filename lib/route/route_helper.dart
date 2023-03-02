import 'package:food_app/details/popular_food_details.dart';
import 'package:food_app/details/recommended_food_details.dart';
import 'package:get/get.dart';

import '../home/main_page.dart';

class RouteHelper{
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId)=>'$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId)=>'$recommendedFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: ()=>MainPage()),
    GetPage(name: popularFood, page: (){
      print("Popular food get called");
      var pageId = Get.parameters['pageId'];
      return PopularFoodDetails(pageId:int.parse(pageId!));
    },
      transition: Transition.fadeIn
    ),
    GetPage(name: recommendedFood, page: (){
      print("Recommended food get called");
      var pageId = Get.parameters['pageId'];
      return RecommendedFoodDetails(pageId:int.parse(pageId!));
    },
        transition: Transition.fadeIn
    ),
  ];
}