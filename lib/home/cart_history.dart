import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/no_data_page.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/model/cart_model.dart';
import 'package:food_app/route/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/small_texts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../widgets/big_texts.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    Map<String,int> cartItemsPerOrder = Map();

    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) =>++value );
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("dd-MM-yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);

      }
      return BigTexts(text: outputDate);
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimension.height10*10,
            color: Colors.greenAccent,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimension.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigTexts(text: "Cart History",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
           return _cartController.getCartHistoryList().length>0?Expanded(
                child:Container(
                    margin: EdgeInsets.only(
                        top: Dimension.height20,
                        left: Dimension.width20,
                        right: Dimension.width20
                    ),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        children: [
                          for(int i=0;i<itemsPerOrder.length;i++)
                            Container(
                              height: Dimension.height30*4,
                              margin: EdgeInsets.only(bottom:Dimension.width20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
                                  SizedBox(height: Dimension.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(itemsPerOrder[i], (index)  {
                                          if(listCounter<getCartHistoryList.length){
                                            listCounter++;
                                          }
                                          return index <=2?Container(
                                            width: Dimension.width20*4,
                                            height: Dimension.height20*4,
                                            margin: EdgeInsets.only(right: Dimension.width10/2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimension.radius15/2),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(getCartHistoryList[listCounter-1].img!)
                                                )
                                            ),
                                          ):Container();
                                        }),
                                      ),
                                      Container(
                                        height: Dimension.height20*4,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SmallTexts(text: "Total",color: Colors.black54,),
                                            BigTexts(text: itemsPerOrder[i]<=1?itemsPerOrder[i].toString()+" Item":itemsPerOrder[i].toString()+" Items",color: Colors.black54,),
                                            GestureDetector(
                                              onTap: (){
                                                print("You are tapped");
                                                var orderTime = cartOrderTimeToList();
                                                Map<int, CartModel> moreOrder = {};
                                                for(int j=0;j<getCartHistoryList.length;j++){
                                                  if(getCartHistoryList[j].time==orderTime[i]){
                                                    print("The product info is "+jsonEncode(getCartHistoryList[j]));
                                                    moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                        CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                    );
                                                  }
                                                }
                                                Get.find<CartController>().setItems = moreOrder;
                                                Get.find<CartController>().addToCartList();
                                                Get.toNamed(RouteHelper.getCartPage());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: Dimension.width10,vertical: Dimension.width10/2),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimension.radius15/3),
                                                    border: Border.all(width: 1,color: Colors.greenAccent)
                                                ),
                                                child: SmallTexts(text: "One more",color: Colors.greenAccent,),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                        ],
                      ),)
                ) ):
           SizedBox(
             height: MediaQuery.of(context).size.height/1.5,
               child: const Center(
                   child: NoDataPage(text: "Your History List is Empty")));
          })
        ],
      ),
    );
  }
}