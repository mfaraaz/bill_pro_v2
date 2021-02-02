import 'package:bill_pro_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemListTile extends StatelessWidget {
  ItemListTile(
      {this.name,
      this.hsn,
      this.unit,
      this.price,
      this.total,
      this.qty,
      this.longPressCallBack});
  final String name;
  final String hsn;
  final String unit;
  final double price;
  final double qty;
  final double total;
  final Function longPressCallBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(4),
        // borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: GestureDetector(
        onLongPress: longPressCallBack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: GoogleFonts.getFont('Montserrat', fontSize: 12),
                ),
                Text(
                  'HSN',
                  style: GoogleFonts.getFont('Montserrat', fontSize: 12),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: GoogleFonts.getFont('Montserrat',
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
                Text(
                  hsn,
                  style: GoogleFonts.getFont('Montserrat',
                      fontSize: 14, fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity',
                          style:
                              GoogleFonts.getFont('Montserrat', fontSize: 14)),
                      Text('Price    ',
                          style:
                              GoogleFonts.getFont('Montserrat', fontSize: 14))
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Total',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$qty',
                          style: GoogleFonts.getFont('Montserrat',
                              fontSize: 14, fontWeight: FontWeight.w700)),
                      Text('$price/$unit',
                          style: GoogleFonts.getFont('Montserrat',
                              fontSize: 14, fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    total.toStringAsFixed(1),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.getFont('Montserrat',
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.white38,
            ),
          ],
        ),
      ),
    );
  }
}
