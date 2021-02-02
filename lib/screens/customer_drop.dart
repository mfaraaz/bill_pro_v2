import 'dart:ui';

import 'package:bill_pro_v2/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/customer.dart';
import '../models/customer_data.dart';
import '../models/others.dart';
import '../models/others_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CustomerDrop extends StatefulWidget {
  @override
  _CustomerDropState createState() => _CustomerDropState();
}

class _CustomerDropState extends State<CustomerDrop> {
  final uid = FirebaseAuth.instance.currentUser.uid;
  DateTime _dateTime;
  Customer item;
  String bill = '', _date = 'Tap';
  String selectedItem = '0';
  Widget updateData() {
    return Container(
      child: Text('Add: ${selectedItem}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context).current;
    return Consumer<CustomerData>(
      builder: (context, customerData, child) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users/$uid/customer')
                    .orderBy('name')
                    .snapshots(),
                builder: (context, customerSnapshot) {
                  if (customerSnapshot.connectionState ==
                      ConnectionState.waiting)
                    return Center(
                      child: Container(),
                    );
                  Provider.of<CustomerData>(context, listen: false).clear();
                  final customerDocs = customerSnapshot.data.documents;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = customerDocs[index];
                      Customer cust = Customer(
                          name: data['name'],
                          address: data['address'],
                          city: data['city'],
                          pan: data['pan'],
                          gst: data['gst'],
                          index:
                              (Provider.of<CustomerData>(context, listen: false)
                                      .length)
                                  .toString());
                      Provider.of<CustomerData>(context, listen: false)
                          .add(cust);
                      return Container();
                    },
                    itemCount: customerDocs.length,
                  );
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Create Bill',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontSize: 20,
                  ),
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
                        SizedBox(
                          height: 25,
                          width: 150,
                          child: TextField(
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontSize: 14,
                              color: kFontColor,
                              fontWeight: FontWeight.w700,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
                              hintText: '#',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              bill = value;
                            },
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            _date,
                            style: GoogleFonts.getFont('Montserrat',
                                fontSize: 14, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.right,
                          ),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2050))
                                .then((date) {
                              setState(() {
                                _dateTime = date;
                                _date =
                                    DateFormat("MMMM dd, y").format(_dateTime);
                              });
                            });
                          },
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
                  'YOUR DETAILS',
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
                          '${user.company}',
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
                              '${user.gst}',
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
                            '${user.address}',
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
                          '${user.accountNumber}',
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
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'CUSTOMER',
                style: GoogleFonts.getFont('Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kFontColor),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: kContainerColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          contentPadding: EdgeInsets.symmetric(horizontal: 18),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              const Radius.circular(4.0),
                            ),
                          ),
                        ),
                        value: selectedItem,
                        // selectedItemBuilder: (BuildContext context) {
                        //   return dataNot.items.map<Widget>((Data item) {
                        //     return Text(item.title);
                        //   }).toList();
                        // },
                        items: customerData.items.map((Customer item) {
                          return DropdownMenuItem<String>(
                            child: Text(
                              item.name,
                              style: GoogleFonts.getFont('Montserrat',
                                  fontWeight: FontWeight.w700,
                                  color: kFontColor),
                            ),
                            value: item.index,
                            //customerData.getIndex(item).toString(),
                          );
                        }).toList(),
                        onChanged: (String string) =>
                            setState(() => selectedItem = string),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent, shape: BoxShape.circle),
                        child: Icon(
                          Icons.cached,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        print('${_date} $bill $selectedItem');
                        Others others = Others(
                          date: _date,
                          billNo: bill,
                          index: selectedItem,
                        );
                        Provider.of<OthersData>(context, listen: false)
                            .update(others);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
