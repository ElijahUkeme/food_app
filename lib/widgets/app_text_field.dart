

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String textHint;
  final IconData icon;
  bool isObscure;
   AppTextField({Key? key, required this.textEditingController,
  required this.textHint, required this.icon,this.isObscure=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimension.width20,right: Dimension.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimension.radius15),
          boxShadow:
          [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        obscureText: isObscure?true:false,
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: textHint,
            prefixIcon: Icon(icon,color: Colors.lightGreen,),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.radius30),
                borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.radius30),
                borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white
                )
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.radius30),

            )
        ),
      ),
    );
  }
}
