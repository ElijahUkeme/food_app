import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:get/get.dart';

import '../controller/popular_product_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../route/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  
  @override
  void initState() {
    super.initState();
    _loadResource();
    controller = AnimationController(vsync: this,
        duration: const Duration(seconds: 5))..forward();
    animation = CurvedAnimation(parent: controller,
        curve: Curves.linear);
    
    Timer(
      const Duration(seconds: 10),
        ()=>Get.offNamed(RouteHelper.getInitial())
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaleTransition(
        scale: animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image.asset("assets/images/moimoi.jpg",fit: BoxFit.contain,),
          ],
        ),
      ),
    );
  }
}
