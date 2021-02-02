import 'package:bill_pro_v2/constants.dart';
import 'package:bill_pro_v2/models/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/item_list_data.dart';
import '../screens/add_item_list.dart';
import '../screens/bill_screen.dart';
import '../screens/customer_drop.dart';
import '../widget/item_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:number_to_words/number_to_words.dart';

class Bills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _total = Provider.of<ItemListData>(context).getTotal();
    double total = _total * 1.05, tax = _total * .05;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              CustomerDrop(),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'ITEMS',
                      style: GoogleFonts.getFont('Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: kFontColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: kContainerColor,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: EdgeInsets.only(top: 10, left: 4, right: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ItemListBuilder(),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: Colors.blueAccent,
                              ),
                              Text(
                                'Add Item',
                                style: GoogleFonts.getFont('Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddItemList(),
                            ),
                          );
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 18,
              ),
              Text(
                'TOTAL',
                style: GoogleFonts.getFont('Montserrat',
                    fontSize: 12, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: kContainerColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gross Total',
                            style: GoogleFonts.getFont('Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: kFontColor),
                          ),
                          Text(
                            _total.toStringAsFixed(1),
                            style: GoogleFonts.getFont('Montserrat',
                                fontSize: 12, color: kFontColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'GST (5%) ',
                            style: GoogleFonts.getFont('Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: kFontColor),
                          ),
                          Text(
                            tax.toStringAsFixed(1),
                            style: GoogleFonts.getFont('Montserrat',
                                fontSize: 12, color: kFontColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grand Total',
                            style: GoogleFonts.getFont('Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: kFontColor),
                          ),
                          Text(
                            total.toStringAsFixed(1),
                            style: GoogleFonts.getFont('Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: kFontColor),
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Visibility(
                      //   visible: total == 0 ? false : true,
                      //   child: Expanded(
                      //     flex: 2,
                      //     child: Container(),
                      //   ),
                      // ),
                      Visibility(
                        visible: total == 0 ? false : true,
                        child: Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 40,
                            width: 120,
                            child: FlatButton(
                              color: Colors.white38,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Clear',
                                style: GoogleFonts.getFont('Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                              onPressed: total == 0
                                  ? null
                                  : () {
                                      Provider.of<ItemListData>(context,
                                              listen: false)
                                          .removeAll();
                                    },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: total == 0 ? false : true,
                        child: Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 40,
                            width: 120,
                            child: FlatButton(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Done',
                                style: GoogleFonts.getFont('Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                              onPressed: total == 0
                                  ? null
                                  : () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BillScreen()));
                                    },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
