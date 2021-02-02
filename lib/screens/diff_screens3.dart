import 'package:bill_pro_v2/screens/saved_bills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:ionicons/ionicons.dart';

import 'bills.dart';
import 'data_screen.dart';
import 'home.dart';
import 'profile.dart';

class DiffScreens3 extends StatefulWidget {
  @override
  _DiffScreens3State createState() => _DiffScreens3State();
}

class _DiffScreens3State extends State<DiffScreens3> {
  int _selectedIndex = 2;
  List<Widget> _widgetOptions = <Widget>[
    SavedBills(),
    Bills(),
    Home(),
    DataScreen(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: Colors.white12,
        behaviour: SnakeBarBehaviour.pinned,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(12), topLeft: Radius.circular(12)),
        // ),
        snakeShape: SnakeShape.indicator,
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: Colors.black54,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white38,

        ///configuration for SnakeNavigationBar.gradient
        //snakeViewGradient: selectedGradient,
        //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        //unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: false,
        showSelectedLabels: false,

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 0
                  ? Ionicons.documents
                  : Ionicons.documents_outline),
              label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? Ionicons.receipt
                  : Ionicons.receipt_outline),
              label: 'Bill'),
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 2 ? Ionicons.home : Ionicons.home_outline),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 3
                  ? Ionicons.people
                  : Ionicons.people_outline),
              label: 'Data'),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 4
                  ? Ionicons.settings
                  : Ionicons.settings_outline),
              label: 'Profile'),
        ],
      ),
    );
  }
}
