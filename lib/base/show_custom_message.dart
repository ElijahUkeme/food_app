import 'package:flutter/material.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,{bool isError=true, String title ="Error"}){
  Get.snackbar(title, message,
  titleText: BigTexts(text: title,color: Colors.white,)
  ,messageText: Text(message,style: const TextStyle(
        color: Colors.white
      ),
      ),
      colorText: Colors.white,
       snackPosition: SnackPosition.TOP,
       backgroundColor: Colors.lightGreen);
}