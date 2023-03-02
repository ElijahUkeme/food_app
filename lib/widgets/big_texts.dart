import 'package:flutter/cupertino.dart';
import 'package:food_app/utils/dimensions.dart';

class BigTexts extends StatelessWidget {

  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  BigTexts({Key? key, this.color=const Color(0xFF332d2b), required this.text,
    this.overFlow = TextOverflow.ellipsis,this.size=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size==0?Dimension.font20:size,
      ),
    );
  }
}
