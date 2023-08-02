import 'package:flutter/material.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/details/recommended_food_details.dart';
import 'package:food_app/home/cart_page.dart';
import 'package:food_app/home/sign_in_page.dart';
import 'package:food_app/home/sign_up_page.dart';
import 'package:food_app/home/splash_page.dart';
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
    Get.find<CartController>().getCartData();
    Get.find<AuthController>();

    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder:(_){

        return GetMaterialApp(
          title: 'Flutter Demo',
          //home: SignInPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          debugShowCheckedModeBanner: false,
        );
      });
    });
  }
}
