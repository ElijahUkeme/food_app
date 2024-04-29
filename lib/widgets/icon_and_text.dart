import 'package:flutter/cupertino.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/small_texts.dart';

class IconAndText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;
  const IconAndText(
      {Key? key,
      required this.iconData,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: Dimension.iconSize24,
        ),
        SizedBox(
          width: 3,
        ),
        SmallTexts(
          text: text,
        ),
      ],
    );
  }
}
