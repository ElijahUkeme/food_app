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
        );
      });
    }else{
      Get.snackbar("item count", "Please Add at least one item",
          backgroundColor: Colors.greenAccent,
          colorText: Colors.white);
    }

   }

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
}