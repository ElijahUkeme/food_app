import 'package:get/get.dart';
class Dimension{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageViewContainer = screenHeight/3.10;
  static double pageViewTextContainer = screenHeight/6.21;
  static double pageView =screenHeight / 2.28;
  //dynamic height padding and margin
  static double height10 = screenHeight/68.3;
  static double height20 = screenHeight/34.2;
  static double height15 = screenHeight/45.5;
  static double height45 = screenHeight/15.18;
  static double height40 = screenHeight/17.08;
  static double height30 = screenHeight/22.8;
//dynamic width padding and margin
  static double width10 = screenHeight/68.3;
  static double width20 = screenHeight/34.2;
  static double width15 = screenHeight/45.5;
  static double width30 = screenHeight/22.8;
  //font size
  static double font16 = screenHeight/42.69;
  static double font26 = screenHeight/26.27;
  static double font20 = screenHeight/34.2;
  //radius
  static double radius15 = screenHeight/45.5;
  static double radius20 = screenHeight/34.2;
  static double radius30 = screenHeight/22.8;

  //icon size
static double iconSize24 = screenHeight/28.46;
  static double iconSize16 = screenHeight/42.69;

//listview size
static double listviewImageSize = screenWidth/3.43;
static double listviewTextContainerSize = screenWidth/4.11;

//popular food size
static double popularFoodImageSize = screenHeight/1.95;

//bottom navigation size
static double bottomBarHeightSize = screenHeight/5.69;

}