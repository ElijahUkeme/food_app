import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/model/cart_model.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/repository/popular_product_repository.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepository popularProductRepository;


  PopularProductController({required this.popularProductRepository});


  List<ProductsModel> _popularProductList=[];
  List<ProductsModel> get popularProductList => _popularProductList;
  late CartController _cartController;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems =0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList()async {
    Response response = await popularProductRepository.getPopularProductList();

    try{


    if(response.statusCode==200){
      print("Got products from the server");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      _isLoaded = true;
      update();
    }
    else{
      print("Error occurred and the error is "+response.body);
    }
    }catch(e){
      print("Error in the controller is "+e.toString());
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
       _quantity = checkQuantity(_quantity +1);
    }else{
       _quantity = checkQuantity(_quantity -1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("item count", "You can't reduce more than 0",
      backgroundColor: Colors.greenAccent,
      colorText: Colors.white);
      if(_inCartItems >0){
        _quantity = - _inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity) >20){
      Get.snackbar("item count", "You can't add more than 20 items",
      backgroundColor: Colors.greenAccent,
      colorText: Colors.white);
      return 20;
    }else{
      return quantity;
    }
  }
  void initProduct(ProductsModel productsModel, CartController cartController){
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;
    var exist = false;
    exist = _cartController.existInCart(productsModel);
    if(exist){
      _inCartItems = _cartController.getQuantity(productsModel);
    }
  }
  void addItem(ProductsModel productsModel){

      _cartController.addItem(productsModel, _quantity);
      _quantity = 0;
      _inCartItems = _cartController.getQuantity(productsModel);

    update();

  }

  int get totalItems{
    return _cartController.totalItems;
  }
  List<CartModel> get getItems{
    return _cartController.getItems;
  }
}