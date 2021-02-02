import 'package:bill_pro_v2/models/item_list_data.dart';
import 'package:bill_pro_v2/models/items_list.dart';
import 'package:bill_pro_v2/widget/item_list_builder.dart';
import 'package:bill_pro_v2/widget/item_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class GetBill extends StatefulWidget {
  GetBill(
      {this.date,
      this.billNo,
      this.total,
      this.address,
      this.noItem,
      this.name,
      this.pan,
      this.gst,
      this.city});
  final String date;
  final String billNo, address, city, pan, total, gst, name, noItem;

  @override
  _GetBillState createState() => _GetBillState();
}

class _GetBillState extends State<GetBill> {
  @override
  Widget build(BuildContext context) {
    double _total = double.parse(widget.total);
    double total = _total * 0.95;
    double tax = total * 0.05;
    final itemList = Provider.of<ItemListData>(context, listen: false).items;
    itemList.clear();
    final uid = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        shadowColor: Color(0xff),
        title: Container(
          child: Text(
            'BILL #${widget.billNo}',
            style: GoogleFonts.getFont('Montserrat',
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                          'Bill Number',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 12,
                            color: kFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Date',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 12,
                            color: kFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.billNo,
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 14,
                            color: kFontColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.date,
                          style: GoogleFonts.getFont('Montserrat',
                              fontSize: 14, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'CUSTOMER',
                  style: GoogleFonts.getFont('Montserrat',
                      color: kFontColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
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
                          widget.name,
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 18,
                            color: kFontColor,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'GSTIN',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontSize: 12,
                                color: kFontColor,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              widget.gst,
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontSize: 12,
                                color: kFontColor,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white38,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            widget.address,
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
                          widget.pan,
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'ITEMS',
                  style: GoogleFonts.getFont('Montserrat',
                      color: kFontColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: kContainerColor,
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(
                          'users/$uid/bills/${widget.billNo}${widget.date}/items')
                      .snapshots(),
                  builder: (context, itemSnapshot) {
                    if (itemSnapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: Container(),
                      );
                    final itemData = itemSnapshot.data.documents;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: itemData.length,
                      itemBuilder: (context, index) {
                        final data = itemData[index];
                        print(data['name']);
                        return ItemListTile(
                            name: data['name'],
                            unit: data['unit'],
                            hsn: data['hsn'],
                            qty: data['qty'],
                            price: data['price'],
                            total: data['total'],
                            longPressCallBack: () {});
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'TOTAL',
                  style: GoogleFonts.getFont('Montserrat',
                      color: kFontColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 10),
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
                            total.toStringAsFixed(1),
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
                            _total.toString(),
                            style: GoogleFonts.getFont('Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: kFontColor),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
