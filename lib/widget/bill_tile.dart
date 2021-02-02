import 'package:bill_pro_v2/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class BillTile extends StatelessWidget {
  BillTile(
      {this.name,
      this.date,
      this.billNo,
      this.address,
      this.noItem,
      this.total,
      this.longPressCallBack,
      this.onTap});
  final String total;
  final String name;
  final String address;
  final String noItem;
  final String date;
  final String billNo;
  final Function longPressCallBack;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: longPressCallBack,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: kContainerColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$name',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontSize: 18,
                    color: kFontColor,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    '#$billNo',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            // Divider(
            //   color: Colors.white38,
            // ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    address,
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontSize: 12,
                      color: kFontColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Text(
                  date,
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontSize: 12,
                    color: kFontColor,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
