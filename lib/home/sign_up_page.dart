import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/model/sign_up_model.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../route/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = [
      "f.png",
      "t.png",
      "g.png"
    ];

    void _registration(AuthController authController){
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String phone = phoneController.text;

      if(name.isEmpty){
        showCustomSnackBar("Please Enter your Name");
      }else if(email.isEmpty){
        showCustomSnackBar("Please Enter your Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Not a Valid Email Format");
      }else if(password.isEmpty){
        showCustomSnackBar("Please Enter your Password");
      }else if(password.length<6){
        showCustomSnackBar("Password Must be at least 6 Characters");
      }else if(phone.isEmpty){
        showCustomSnackBar("Please Enter your Phone Number");
      }else{

        SignUpModel signUpModel = SignUpModel(
            name: name,
            email: email,
            password: password,
            phone: phone);
        authController.registration(signUpModel).then((status) {
          if(status.isSuccess){
            Get.offNamed(RouteHelper.getInitial());
            print("Page success message is "+status.message);
          }else{
            //showCustomSnackBar(status.message);
          }
        });

      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
              AppTextField(
                  textEditingController: emailController,
                  textHint: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimension.height15,),
              AppTextField(
                  textEditingController: passwordController,
                  textHint: "Password",
                  icon: Icons.password_outlined,isObscure: true,),
              SizedBox(height: Dimension.height15,),
              AppTextField(
                  textEditingController: nameController,
                  textHint: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimension.height15,),
              AppTextField(
                  textEditingController: phoneController,
                  textHint: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimension.height15,),

              GestureDetector(
                onTap: (){
                  _registration(_authController);
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
                      text:"Sign Up",size: Dimension.font20+Dimension.font20/2,color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: Dimension.height10,),
              RichText(
                  text:TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Already Have An Account?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimension.font20
                      )
                  ) ),
              SizedBox(height: Dimension.screenHeight*0.05,),

              RichText(
                  text:TextSpan(
                      text: "Sign Up With",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimension.font16
                      )
                  ) ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimension.radius30,
                    backgroundImage: AssetImage("assets/images/"+signUpImage[index]),
                  ),
                )),
              )
            ],
          ),
        ):CustomLoader();
      }),
    );
  }

}
