import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/home/cart_page.dart';
import 'package:food_app/home/main_page.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_column.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../route/route_helper.dart';
import '../widgets/big_texts.dart';
import '../widgets/icon_and_text.dart';
import '../widgets/small_texts.dart';

class PopularFoodDetails extends StatelessWidget {
  int pageId;
  final String page;

  PopularFoodDetails({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    print("Product id is " + pageId.toString());
    print("product name is " + product.name.toString());
    print("current height is " + MediaQuery.of(context).size.height.toString());
    print("current screen width is " +
        MediaQuery.of(context).size.width.toString());
    return Scaffold(
        //backgroundColor: Colors.white,
        body: Stack(
          children: [
            //background image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimension.popularFoodImageSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(product.img!))),
              ),
            ),
            //icon widgets
            Positioned(
              top: Dimension.height45,
              left: Dimension.width20,
              right: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(
                    builder: ((controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.totalItems >= 1)
                            Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.add_shopping_cart_outlined),
                            controller.totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: Colors.greenAccent,
                                    ),
                                  )
                                : Container(),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 3,
                                    top: 3,
                                    child: BigTexts(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: 12,
                                      color: Colors.white,
                                    ))
                                : Container()
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
            //introduction of food widget
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimension.popularFoodImageSize - 20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimension.width20,
                      right: Dimension.width20,
                      top: Dimension.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimension.radius20),
                          topLeft: Radius.circular(Dimension.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!),
                      SizedBox(height: Dimension.height20),
                      BigTexts(text: "Introduce"),
                      SizedBox(
                        height: Dimension.height15,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                                text: product.description!)),
                      ),
                    ],
                  )),
            )
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popularProduct) {
          return Container(
            height: Dimension.bottomBarHeightSize,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimension.height20,
                      bottom: Dimension.height20,
                      left: Dimension.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      BigTexts(text: popularProduct.inCartItems.toString()),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimension.height20,
                        bottom: Dimension.height20,
                        left: Dimension.width20,
                        right: Dimension.width20),
                    child: BigTexts(
                      text: "# ${product.price!} | Add to cart",
                      color: Colors.white,
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
}
