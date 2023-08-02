import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/details/popular_food_details.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/route/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_column.dart';
import 'package:food_app/widgets/big_texts.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_texts.dart';
import 'package:get/get.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimension.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder:(popularProducts){
            return popularProducts.isLoaded?Container(
              height: Dimension.pageView,
              //color: Colors.yellow,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position,popularProducts.popularProductList[position]);
                  }),
            ):CircularProgressIndicator(
              color: Colors.blue
            );
          }),

        //slider section
        SizedBox(
          height: Dimension.height10,
        ),
        //dots section
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return DotsIndicator(
            dotsCount:popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        } ),
        //popular text
        SizedBox(
          height: Dimension.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimension.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigTexts(text: "Recommended"),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigTexts(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallTexts(text: "Food Pairing"),
              )
            ],
          ),
        ),
        //List of food and images

        GetBuilder<RecommendedProductController>(builder: (recommendedProducts){
          return recommendedProducts.isLoaded?ListView.builder(
              shrinkWrap: true,
              //physics: AlwaysScrollableScrollPhysics(),
              physics: NeverScrollableScrollPhysics(),
              itemCount: recommendedProducts.recommendedProductList.length,
              itemBuilder: (contex,index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimension.width20,right: Dimension.width20,top: Dimension.height15),
                    child:
                    Row(
                      children: [
                        //images on the row section
                        Container(
                          width:Dimension.listviewImageSize,
                          height: Dimension.listviewImageSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimension.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(recommendedProducts.recommendedProductList[index].img!),

                              )
                          ),
                        ),
                        //text section
                        Expanded(
                          child: Container(
                            height: Dimension.listviewTextContainerSize,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimension.radius20),
                                  bottomRight: Radius.circular(Dimension.radius20),
                                ),
                                color: Colors.white
                            ),
                            child:Padding(
                              padding: EdgeInsets.only(left: Dimension.width10,right: Dimension.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigTexts(text: recommendedProducts.recommendedProductList[index].name!),
                                  SizedBox(height: Dimension.height10,),
                                  SmallTexts(text: "With African Characteristics"),
                                  SizedBox(height: Dimension.height10,),
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
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }):
              CircularProgressIndicator(
                color: Colors.blue,
              );

        }),

      ],
    );
  }

  Widget _buildPageItem(int index, ProductsModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
            },
            child: Container(
              height: Dimension.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimension.width10, right: Dimension.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    popularProduct.img!
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimension.width30, right: Dimension.width30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                  //bottom: Dimension.height15,
                    top: Dimension.height15,
                    left: Dimension.width15,
                    right: Dimension.width15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
