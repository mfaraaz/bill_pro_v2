import 'package:bill_pro_v2/widget/bill_data_builder.dart';

import '../screens/add_product.dart';
import '../widget/product_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedBills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Saved Bills',
                style: GoogleFonts.getFont('Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            ),
            Expanded(
              child: Container(
                child: BillDataBuilder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
