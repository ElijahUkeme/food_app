import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_texts.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigTexts bigTexts;
   AccountWidget({Key? key, required this.appIcon,required this.bigTexts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(left: Dimension.width20,
          top: Dimension.height10,bottom: Dimension.height10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimension.width20,),
          bigTexts
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
    );
  }
}
