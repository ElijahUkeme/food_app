import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/small_texts.dart';

import 'big_texts.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigTexts(text: text,size: Dimension.font26,),
        SizedBox(
          height: Dimension.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    color: Colors.greenAccent,
                    size: 15,
                  )),
            ),
            SizedBox(
              width: Dimension.width10,
            ),
            SmallTexts(text: "4.5"),
            SizedBox(
              width: Dimension.width10,
            ),
            SmallTexts(text: "1238"),
            SizedBox(
              width: Dimension.width10,
            ),
            SmallTexts(text: "comments")
          ],
        ),
        SizedBox(
          height: Dimension.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                iconData: Icons.circle_sharp,
                text: "Normal",
                iconColor: Colors.yellow),
            IconAndText(
                iconData: Icons.location_on,
                text: "1.7km",
                iconColor: Colors.greenAccent),
            IconAndText(
                iconData: Icons.access_time_rounded,
                text: "32mins",
                iconColor: Colors.purpleAccent),
          ],
        )
      ],
    );
  }
}
