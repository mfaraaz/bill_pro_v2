import 'package:bill_pro_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayContainer extends StatelessWidget {
  DisplayContainer(
    this.data,
  );
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          color: kContainerColor,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            // BoxShadow(
            //   offset: const Offset(5.0, 5.0),
            //   color: Colors.black12,
            //   blurRadius: 4.0,
            //   spreadRadius: .1,
            // ),
          ]),
      child: Text(
        '$data',
        style: GoogleFonts.getFont('Montserrat', fontSize: 14),
      ),
    );
    ;
  }
}
