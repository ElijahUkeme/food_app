import 'package:flutter/material.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/details/recommended_food_details.dart';
import 'package:food_app/home/cart_page.dart';
import 'package:food_app/route/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependency.dart' as dep;
import 'home/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      title: 'Flutter Demo',

      home: const MainPage(),// RecommendedFoodDetails(), //PopularFoodDetails(),//
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
        debugShowCheckedModeBanner: false,
    );
  }
}
