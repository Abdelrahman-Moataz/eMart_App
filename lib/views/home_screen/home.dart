import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/home_controller.dart';
import 'package:emart/views/cart_screen/cart_screen.dart';
import 'package:emart/views/category_screen/category_screen.dart';
import 'package:emart/views/home_screen/homeScreen.dart';
import 'package:emart/views/profile_screen/profile_screen.dart';
import 'package:emart/widgets_common/exit_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //init home controller
    var controller = Get.put(HomeController());

    var navBarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26),label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26),label: category),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26),label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26),label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];


    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (context)=> exitDialog(context),
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value),)),
          ],
        ),
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(
             currentIndex: controller.currentNavIndex.value,
            backgroundColor: whiteColor,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            items: navBarItem,
             onTap: (value){
               controller.currentNavIndex.value = value;
             },
          ),
        ),
      ),
    );
  }
}
