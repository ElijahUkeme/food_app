import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimension.height20 * 5,
        width: Dimension.height20 * 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimension.height20 * 5 / 2),
            color: Colors.white),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );
  }
}
