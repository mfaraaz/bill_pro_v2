import 'package:bill_pro_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class ProductTile extends StatelessWidget {
  ProductTile({this.name, this.hsn, this.unit, this.longPressCallBack});
  final String name;
  final String hsn;
  final String unit;
  final Function longPressCallBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(4),
      ),
      // padding: EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors
              .black, //Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          child: Text(
            '${name[0]}',
            style: GoogleFonts.getFont('Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
        ),
        onLongPress: longPressCallBack,
        title: Container(
          // padding: EdgeInsets.all(2),
          child: Text(
            '$name',
            style: GoogleFonts.getFont('Montserrat',
                color: kFontColor, fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        subtitle: Text(
          '$hsn',
          style: GoogleFonts.getFont('Montserrat',
              color: Colors.white60, fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ),
    );
  }
}
