import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/small_texts.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {

  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimension.screenHeight/6.83;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallTexts(text: firstHalf,color: Colors.blueGrey,size: Dimension.font16,):Column(
        children: [
          SmallTexts(text: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf),size: Dimension.font16,color: Colors.blueGrey,),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                hiddenText?SmallTexts( text: "show more",color: Colors.greenAccent,):SmallTexts( text: "show less",color: Colors.greenAccent,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: Colors.greenAccent,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
