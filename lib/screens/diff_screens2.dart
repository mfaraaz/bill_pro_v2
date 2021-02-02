import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'bills.dart';
import 'data_screen.dart';
import 'home.dart';
import 'profile.dart';

void main() => runApp(MaterialApp(home: DiffScreens2()));

class DiffScreens2 extends StatefulWidget {
  @override
  _DiffScreens2State createState() => _DiffScreens2State();
}

class _DiffScreens2State extends State<DiffScreens2> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Bills(),
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
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _selectedIndex,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.call_split, size: 30),
        ],
        color: Color(0xff393939),
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: _onItemTapped,
        letIndexChange: (index) => true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
