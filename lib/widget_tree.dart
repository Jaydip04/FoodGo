import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_go/common/constants.dart';
import 'package:food_go/pages/add_item_page.dart';
import 'package:food_go/pages/chat_page.dart';
import 'package:food_go/pages/favorite_page.dart';
import 'package:food_go/pages/home_page.dart';
import 'package:food_go/pages/profile_page.dart';

class widget_tree extends StatefulWidget {
  const widget_tree({super.key});

  @override
  State<widget_tree> createState() => _widget_treeState();
}

class _widget_treeState extends State<widget_tree> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0
          ? home_page()
          : currentIndex == 1
          ? profile_page()
          : currentIndex == 2
          ? add_item_page()
          : currentIndex == 3
          ? chat_page()
          : currentIndex == 4
          ? favorite_page()
          : home_page(),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        color: constants.my_primary,

        backgroundColor: Colors.transparent,
        items: <Widget>[

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/bottom_navigation_bar_icon/home.png',
              color: Colors.white,
              height: 24,
              width: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/bottom_navigation_bar_icon/profile.png',
              color: Colors.white,
              height: 24,
              width:24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/bottom_navigation_bar_icon/add_item.png',
              color: Colors.white,
              height: 24,
              width: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/bottom_navigation_bar_icon/chat.png',
              color: Colors.white,
              height: 24,
              width: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/bottom_navigation_bar_icon/favorite.png',
              color: Colors.white,
              height: 24,
              width: 24,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
