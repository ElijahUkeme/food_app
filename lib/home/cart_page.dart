import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/no_data_page.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/home/main_page.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:food_app/widgets/small_texts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../route/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimension.height20*3,
              right: Dimension.width20,
              left: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios,iconColor: Colors.white,backgroundColor: Colors.greenAccent,
                  iconSize: Dimension.iconSize24,),
                  SizedBox(width: Dimension.width20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,iconColor: Colors.white,backgroundColor: Colors.greenAccent,
                      iconSize: Dimension.iconSize24,),
                  ),
                  AppIcon(icon: Icons.shopping_cart,iconColor: Colors.white,backgroundColor: Colors.greenAccent,
                    iconSize: Dimension.iconSize24,),
                ],

          )),
         GetBuilder<CartController>(builder: (_cartController){
          return _cartController.getItems.length>0? Positioned(
              top: Dimension.height20*5,
              left: Dimension.width20,
              right: Dimension.width20,
              bottom: 0,
              child:
              Container(
                  margin: EdgeInsets.only(top: Dimension.height10),
                  //color: Colors.orange,
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder:(cartController){
                        var _cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index){
                              return Container(
                                height: Dimension.width20*5,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                        onTap: (){
                                          var popularIndex = Get.find<PopularProductController>()
                                              .popularProductList
                                              .indexOf(_cartList[index].product!);

                                          if(popularIndex >=0){
                                            Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));

                                          }else{
                                            var recommendedIndex = Get.find<RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(_cartList[index].product!);
                                            if(recommendedIndex<0){
                                              Get.snackbar("History Product", "Product review not available for the history",
                                                  backgroundColor: Colors.greenAccent,
                                                  colorText: Colors.white);
                                            }else{
                                              Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                            }
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: Dimension.width10),
                                          width: Dimension.width20*5,
                                          height: Dimension.width20*5,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      cartController.getItems[index].img!
                                                  )
                                              ),
                                              borderRadius: BorderRadius.circular(Dimension.radius20),
                                              color: Colors.white
                                          ),
                                        )
                                    ),
                                    SizedBox(width: Dimension.width10,),
                                    Expanded(child: Container(
                                      height: Dimension.height20*5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigTexts(text: cartController.getItems[index].name!,color: Colors.black54,),
                                          SmallTexts(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigTexts(text: cartController.getItems[index].price!.toString(),color: Colors.orange,),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimension.height10,
                                                    bottom: Dimension.height10,
                                                    left: Dimension.width10,
                                                    right: Dimension.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimension.radius20),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(_cartList[index].product!, -1);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.grey,
                                                        )),
                                                    SizedBox(
                                                      width: Dimension.width10 / 2,
                                                    ),
                                                    BigTexts(text:_cartList[index].quantity.toString()), //popularProduct.inCartItems.toString()),
                                                    SizedBox(
                                                      width: Dimension.width10 / 2,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(_cartList[index].product!, 1);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.grey,
                                                        ))
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            });
                      })
                  )
              )):NoDataPage(text: "Your Cart is Empty!");
          })
        ],
      ),
        bottomNavigationBar:
        GetBuilder<CartController>(builder: (cartController) {
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
            child:cartController.getItems.length>0? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimension.height20,
                      bottom: Dimension.height20,
                      left: Dimension.width20,
                      right: Dimension.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      BigTexts(text:"# "+ cartController.totalAmount.toString()),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    if(Get.find<AuthController>().userLoggedIn()){
                      cartController.addToHistory();
                      //cartController.clearCartList();
                    }else{
                      Get.toNamed(RouteHelper.getSignInPage());
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimension.height20,
                        bottom: Dimension.height20,
                        left: Dimension.width20,
                        right: Dimension.width20),

                    child: BigTexts(
                      text: "Check out",
                      color: Colors.white,
                    ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: Colors.greenAccent),
                  ),
                )
              ],
            ):Container(),
          );
        })
    );
  }
}
