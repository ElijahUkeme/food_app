import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/customer_controller.dart';
import 'package:food_app/home/main_page.dart';
import 'package:food_app/route/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/account_widget.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:get/get.dart';
import '../widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _authController = Get.find<AuthController>();
    bool _isUserLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_isUserLoggedIn){

      print("Retrieved token for the user from the account page is "+_authController.getUserToken());
      print(Get.find<CustomerController>().getUserInfo(AppConstants.TOKEN));
     Get.find<CustomerController>().getUserInfo(_authController.getUserToken());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Center(child: BigTexts(text: "Profile",size:24,color: Colors.white,)),
      ),
      body: GetBuilder<CustomerController>(builder: (customerController){

        return _isUserLoggedIn?(customerController.isLoading?
        Container(
          margin: EdgeInsets.only(top: Dimension.height20),
          width: double.maxFinite,
          child: Column(
            children: [
              AppIcon(icon: Icons.person,backgroundColor: Colors.greenAccent,
                iconSize: Dimension.height45+Dimension.height30,iconColor: Colors.white,
                size: Dimension.height40*3,),
              SizedBox(height: Dimension.height20,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.person,backgroundColor: Colors.greenAccent,
                              iconSize: Dimension.height10*5/2,iconColor: Colors.white,
                              size: Dimension.height10*5),
                          bigTexts: BigTexts(text: customerController.customerModel.name)),
                      SizedBox(height: Dimension.height10,),

                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.phone,backgroundColor: Colors.lightGreen,
                              iconSize: Dimension.height10*5/2,iconColor: Colors.white,
                              size: Dimension.height10*5),
                          bigTexts: BigTexts(text: customerController.customerModel.phone)),
                      SizedBox(height: Dimension.height10,),

                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.email,backgroundColor: Colors.lightGreen,
                              iconSize: Dimension.height10*5/2,iconColor: Colors.white,
                              size: Dimension.height10*5),
                          bigTexts: BigTexts(text: customerController.customerModel.email)),
                      SizedBox(height: Dimension.height10,),

                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.location_on,backgroundColor: Colors.purpleAccent,
                              iconSize: Dimension.height10*5/2,iconColor: Colors.white,
                              size: Dimension.height10*5),
                          bigTexts: BigTexts(text: "Address")),
                      SizedBox(height: Dimension.height10,),

                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.message_outlined,backgroundColor: Colors.greenAccent,
                              iconSize: Dimension.height10*5/2,iconColor: Colors.white,
                              size: Dimension.height10*5),
                          bigTexts: BigTexts(text: "Message")),
                      SizedBox(height: Dimension.height10,),

                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clearCartList();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }else{
                            print("You logged out");
                          }
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(icon: Icons.logout,backgroundColor: Colors.greenAccent,
                                iconSize: Dimension.height10*5/2,iconColor: Colors.white,
                                size: Dimension.height10*5),
                            bigTexts: BigTexts(text: "Logout")),
                      ),
                      SizedBox(height: Dimension.height10,),


                    ],
                  ),
                ),
              )
            ],
          ),
        ):CustomLoader()):
        Container(child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimension.height20*8,
              margin: EdgeInsets.only(left: Dimension.width20,right: Dimension.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:AssetImage("assets/images/seller.png") )
              ),
            ),
            SizedBox(height: Dimension.height10,),
            Container(
              width: double.maxFinite,
              height: Dimension.height20*4,
              margin: EdgeInsets.only(left: Dimension.width20,right: Dimension.width20),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(Dimension.radius20),
              ),
              child: Center(child: GestureDetector(
                       onTap: (){
                         Get.offNamed(RouteHelper.getSignInPage());
                       },
                  child: BigTexts(text: "Sign in",color: Colors.white,))),
            )
          ],
        )
        ),
        );
      })
    );
  }
}
