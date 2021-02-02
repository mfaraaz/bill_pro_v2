import 'package:bill_pro_v2/screens/diff_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'diff_screens2.dart';
import 'diff_screens3.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        shadowColor: Color(0xff),
        title: Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'billPRO',
            style: GoogleFonts.getFont('Montserrat',
                color: kFontColor, fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ),
      ),
      body: DiffScreens3(),
    );
  }
}
