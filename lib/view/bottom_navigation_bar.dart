import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/view/categories_screen.dart';
import 'package:flutter_task/view/favourite_screen.dart';
import 'package:flutter_task/view/products_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Widget> screen= [ProductsScreen(),CategoriesScreen(),FavouriteScreen()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: index,
        onTap: (value){
          setState(() {

          });
          index = value;
        },
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400
        ),
        unselectedLabelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400
        ),
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon.png', height: 20, width: 20),
            label: 'Products'

          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_grid_2x2,color: Colors.white,),
          label: 'Categories'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border,color: Colors.white,),
              label: 'Favourite',
          )
        ],
      ),
    );
  }
}
