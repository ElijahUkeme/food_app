
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/home/sign_up_page.dart';
import 'package:food_app/route/route_helper.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../base/show_custom_message.dart';
import '../controller/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){

      String email = emailController.text;
      String password = passwordController.text;



       if(email.isEmpty){
        showCustomSnackBar("Please Enter your Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Not a Valid Email Format");
      }else if(password.isEmpty){
        showCustomSnackBar("Please Enter your Password");
      }else if(password.length<6){
        showCustomSnackBar("Password Must be at least 6 Characters");
      }else{

        authController.login(email,password).then((status) {
          if(status.isSuccess){
            print("Page success message is "+status.message);
            Get.offNamed(RouteHelper.getInitial());
          }else{
            //showCustomSnackBar(status.message);
          }
        });

      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimension.screenHeight*0.05,),
              Container(
                height: Dimension.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/images/cart.png"
                    ),
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimension.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimension.font20*3,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Sign into your Account",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimension.font20,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimension.height20,),
              AppTextField(
                  textEditingController: emailController,
                  textHint: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimension.height20,),
              AppTextField(
                textEditingController: passwordController,
                textHint: "Password",
                icon: Icons.password_outlined,isObscure: true,),
              SizedBox(height: Dimension.height20,),


              SizedBox(height: Dimension.screenHeight*0.05,),

              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimension.screenWidth/2,
                  height: Dimension.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius30),
                      color: Colors.lightGreen
                  ),
                  child: Center(
                    child: BigTexts(
                      text:"Sign In",size: Dimension.font20+Dimension.font20/2,color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: Dimension.screenHeight*0.05,),

              RichText(
                  text:TextSpan(
                      text: "Don\'t have an Account?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimension.font16
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignUpPage(),
                                transition: Transition.fade),
                            text: "  Create",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: Dimension.font16,
                                fontWeight: FontWeight.bold
                            )),
                      ]
                  ) ),
            ],
          ),
        ):CustomLoader();
      }),
    );
  }
}
