import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/account/account_page.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/home/cart_history.dart';
import 'package:food_app/home/cart_page.dart';
import 'package:food_app/home/main_page.dart';
import 'package:food_app/home/sign_in_page.dart';
import 'package:food_app/home/sign_up_page.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;


  List pages = [
    MainPage(),
    Container(child: Text("History page"),),
    CartHistory(),
    AccountPage()

  ];
  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>();
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightGreen,
          unselectedItemColor: Colors.amberAccent,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _selectedIndex,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          onTap: onTapNav,

          items: const [

        BottomNavigationBarItem(
            icon:Icon(Icons.home_outlined),label: "home"),
        BottomNavigationBarItem(
            icon:Icon(Icons.archive),label: "history"),
        BottomNavigationBarItem(
            icon:Icon(Icons.shopping_cart),label: "cart"),
        BottomNavigationBarItem(
            icon:Icon(Icons.person),label: "me"),

      ]),
    );
  }


}
