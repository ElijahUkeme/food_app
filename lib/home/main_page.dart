import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:food_app/widgets/small_texts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/popular_product_controller.dart';
import '../controller/recommended_product_controller.dart';
import 'food_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    print("current height is "+MediaQuery.of(context).size.height.toString());
    print("current screen width is "+MediaQuery.of(context).size.width.toString());
    return RefreshIndicator(child: Column(
      children: [
        Container(
          child: Container(
            margin:  EdgeInsets.only(top: Dimension.height40,bottom: Dimension.width15),
            padding:  EdgeInsets.only(left: Dimension.width20,right: Dimension.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children:  [
                    BigTexts(text: "Nigeria",color: Colors.greenAccent,),
                    Row(
                      children: [
                        SmallTexts(text: "Calabar",color: Colors.black54,),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimension.height45,
                    height: Dimension.height45,
                    child:  Icon(Icons.search,color: Colors.white,size: Dimension.iconSize24,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius15),
                      color: Colors.greenAccent,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: FoodPage(),
          ),
        )
      ],
    ), onRefresh: _loadResource);
  }
}
