import 'package:flutter/material.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/repository/cart_repository.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';

class CartController extends GetxController{
 final CartRepository cartRepository;
 CartController({required this.cartRepository});

 Map<int, CartModel> _items = {};
 Map <int,CartModel> get items =>_items;
 List<CartModel> storageItems = [];

 void addItem(ProductsModel productsModel, int quantity){
   var totalQuantity = 0;
   if(_items.containsKey(productsModel.id!)){
     _items.update(productsModel.id!, (value)  {
       totalQuantity = value.quantity!+quantity;
       return CartModel(
           id: value.id,
           name: value.name,
           price: value.price,
           img: productsModel.img,
           quantity: value.quantity!+quantity,
           isExist: true,
         time: DateTime.now().toString(),
         product: productsModel,
       );
     });
     if(totalQuantity<=0){
       _items.remove(productsModel.id);
     }

   }else{
    if(quantity>0){
      _items.putIfAbsent(productsModel.id!, () {

        print("Adding a product to the cart");
        return CartModel(
          id: productsModel.id,
          name: productsModel.name,
          price: productsModel.price,
          img: productsModel.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: productsModel,
        );
      });
    }else{
      Get.snackbar("item count", "Please Add at least one item",
          backgroundColor: Colors.greenAccent,
          colorText: Colors.white);
    }

   }
   cartRepository.addToCartList(getItems);
   update();

 }
 bool existInCart(ProductsModel productsModel){
   if(_items.containsKey(productsModel.id)){
     return true;
   }else{
     return false;
   }
 }

 int getQuantity(ProductsModel productsModel){
   var  quantity = 0;
   if(_items.containsKey(productsModel.id)){
     _items.forEach((key, value) {
       if(key==productsModel.id){
         quantity = value.quantity!;
       }
     });
   }
   return quantity;
 }

 int get totalItems{
   var totalQuantity = 0;
   _items.forEach((key, value) {
     totalQuantity += value.quantity!;
   });
   return totalQuantity;
 }

 List<CartModel> get getItems{
   return _items.entries.map((e) {
     return e.value;
   }).toList();
 }
 int get totalAmount{
   var total = 0;
   _items.forEach((key, value) {
     total += value.price!*value.quantity!;
   });
   return total;
 }

 List<CartModel> getCartData(){
   setCart = cartRepository.getCartList();
   return storageItems;
 }
  set setCart(List<CartModel> items){
   storageItems = items;
   print("length of cart items is "+storageItems.length.toString());
   for(int i=0;i<storageItems.length;i++){
     _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
   }

  }
  void addToHistory(){
   cartRepository.addToCartHistoryList();
   clear();
  }
  void clear(){
   _items = {};
   update();
  }

  List<CartModel> getCartHistoryList(){
   return cartRepository.getCartHistoryList();
  }
  set setItems(Map<int, CartModel> setItems){
   _items = {};
   _items = setItems;
  }
  void addToCartList(){
   cartRepository.addToCartList(getItems);
   update();
  }
  void clearCartList(){
   cartRepository.clearTheCartLIst();
   clear();
   update();
  }
}