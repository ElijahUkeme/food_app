import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/home/main_page.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:food_app/widgets/small_texts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

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
                      Get.to(()=>MainPage());
                    },
                    child: AppIcon(icon: Icons.home_outlined,iconColor: Colors.white,backgroundColor: Colors.greenAccent,
                      iconSize: Dimension.iconSize24,),
                  ),
                  AppIcon(icon: Icons.shopping_cart,iconColor: Colors.white,backgroundColor: Colors.greenAccent,
                    iconSize: Dimension.iconSize24,),
                ],

          )),
          Positioned(
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
                return ListView.builder(
                    itemCount: cartController.getItems.length,
                    itemBuilder: (_, index){
                      return Container(
                        height: Dimension.width20*5,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: Dimension.width10),
                              width: Dimension.width20*5,
                              height: Dimension.width20*5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                      )
                                      ),
                                  borderRadius: BorderRadius.circular(Dimension.radius20),
                                  color: Colors.white
                              ),
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
                                                  //popularProduct.setQuantity(false);
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.grey,
                                                )),
                                            SizedBox(
                                              width: Dimension.width10 / 2,
                                            ),
                                            BigTexts(text:"0"), //popularProduct.inCartItems.toString()),
                                            SizedBox(
                                              width: Dimension.width10 / 2,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  //popularProduct.setQuantity(true);
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
          ))
        ],
      ),
    );
  }
}
