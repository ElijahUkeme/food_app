import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/home/cart_page.dart';
import 'package:food_app/route/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/cart_controller.dart';

class RecommendedFoodDetails extends StatelessWidget {
  int pageId;
  final String page;
  RecommendedFoodDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
                //AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopularProductController>(builder: ((controller) {
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1)
                        Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.add_shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right:0,top:0,
                            child: AppIcon(icon: Icons.circle, size: 20, iconColor: Colors.transparent,
                              backgroundColor: Colors.greenAccent,),

                        ):
                        Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                            right:3,top:3,
                            child: BigTexts(text: Get.find<PopularProductController>().totalItems.toString(),
                              size: 12,color: Colors.white,)
                        ):
                        Container()
                      ],
                    ),
                  );
                }),)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(

                  child: Center(
                      child: BigTexts(
                          text: product.name!, size: Dimension.font26)
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimension.radius20),
                          topLeft: Radius.circular(Dimension.radius20)
                      )
                  )
              ),),
            pinned: true,
            backgroundColor: Colors.orange,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child:ExpandableTextWidget(text: product.description!),
                  margin: EdgeInsets.only(
                      left: Dimension.width20, right: Dimension.width20),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: ((controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: Dimension.height10,
                bottom: Dimension.height10,
                right: Dimension.width20 * 2.5,
                left: Dimension.width20 * 2.5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child:
                    AppIcon(icon: Icons.remove,
                      backgroundColor: Colors.greenAccent,
                      iconColor: Colors.white,
                      iconSize: Dimension.iconSize24,),
                  ),
                  BigTexts(text: "\# ${product.price!} X   ${controller.inCartItems}", size: Dimension.font26,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child:
                    AppIcon(icon: Icons.add,
                      backgroundColor: Colors.greenAccent,
                      iconColor: Colors.white,
                      iconSize: Dimension.iconSize24,),
                  )
                ],
              ),
            ),
            Container(
              height: Dimension.bottomBarHeightSize,
              padding: EdgeInsets.only(top: Dimension.height30,
                  bottom: Dimension.height30,
                  left: Dimension.width20,
                  right: Dimension.width20),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimension.radius20 * 2),
                      topRight: Radius.circular(Dimension.radius20 * 2)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: Dimension.height20,
                          bottom: Dimension.height20,
                          left: Dimension.width20,
                          right: Dimension.width20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimension.radius20),
                          color: Colors.white
                      ),
                      child:
                      Icon(
                        Icons.favorite,
                        color: Colors.greenAccent,
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child:
                    Container(
                      padding: EdgeInsets.only(top: Dimension.height20,
                          bottom: Dimension.height20,
                          left: Dimension.width20,
                          right: Dimension.width20),
                      child: BigTexts(
                        text: "\# ${product.price!} | Add to cart", color: Colors.white,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimension.radius20),
                          color: Colors.greenAccent
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),)
    );
  }
}
