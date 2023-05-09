import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:spoonacular/view/pages/calorie.dart';
import 'package:spoonacular/view/pages/favourite.dart';
import 'package:spoonacular/view/pages/home.dart';

class DashBoard extends StatefulWidget {


  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Calorie(),
    Favourite()

  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 450),
          transitionBuilder: (Widget child, Animation<double> primaryAnimation, Animation<double> secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: Container(
        padding:  EdgeInsets.symmetric(vertical: 8.0,
            horizontal: MediaQuery.of(context).size.width * 0.1),
        decoration: BoxDecoration(
          color: Colors.green,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))
        ),
        child: GNav(
          backgroundColor: Colors.green,
          tabBackgroundColor: Colors.green.shade900,
          textSize: 0.0,
          color: Colors.white,
          activeColor: Colors.white,
          gap: 8,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          selectedIndex: _selectedIndex,
          onTabChange: (index){
            setState(() {
              _selectedIndex = index;
            });
          },

          tabs: [
            GButton(icon: CupertinoIcons.home, text: 'Home',),
            GButton(icon: CupertinoIcons.doc_chart, text: 'Calorie',),
            GButton(icon: CupertinoIcons.heart, text: 'Favourite',),
          ],
        ),
      ),
    );
  }
}
