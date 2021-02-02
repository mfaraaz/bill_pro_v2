import 'package:bill_pro_v2/screens/bills.dart';
import 'package:bill_pro_v2/screens/data_screen.dart';
import 'package:bill_pro_v2/screens/product_screen.dart';
import 'package:bill_pro_v2/screens/profile.dart';
import 'package:bill_pro_v2/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'home.dart';

class DiffScreens extends StatefulWidget {
  @override
  _DiffScreensState createState() => _DiffScreensState();
}

class _DiffScreensState extends State<DiffScreens> {
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
        backgroundColor: Colors.black,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: TitledBottomNavigationBar(
            activeColor: Colors.black,
            indicatorColor: Colors.blueAccent,
            currentIndex:
                _selectedIndex, // Use this to update the Bar giving a position
            onTap: _onItemTapped,
            items: [
              TitledNavigationBarItem(
                  title: Text(
                    'Home',
                    style: GoogleFonts.getFont('Montserrat'),
                  ),
                  icon: Icons.home),
              TitledNavigationBarItem(
                  title: Text('Bill', style: GoogleFonts.getFont('Montserrat')),
                  icon: Icons.receipt_long),
              TitledNavigationBarItem(
                title: Text('Data', style: GoogleFonts.getFont('Montserrat')),
                icon: Icons.storage,
              ),
              TitledNavigationBarItem(
                  title:
                      Text('Profile', style: GoogleFonts.getFont('Montserrat')),
                  icon: Icons.person),
            ]));
  }
}
