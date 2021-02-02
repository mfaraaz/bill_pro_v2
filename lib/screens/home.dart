import 'dart:ui';

import 'package:bill_pro_v2/models/user.dart';
import 'package:bill_pro_v2/models/user_data.dart';
import 'package:bill_pro_v2/screens/add_customer.dart';
import 'package:bill_pro_v2/screens/bill_screen.dart';
import 'package:bill_pro_v2/screens/bills.dart';
import 'package:bill_pro_v2/widget/custom_button.dart';
import 'package:bill_pro_v2/widget/custom_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'add_product.dart';

class Home extends StatelessWidget {
  String _company, _address, _email, _gst, _pan, _bank, _ifsc, _accountNumber;
  Future<String> getData(String type) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    final String uid = FirebaseAuth.instance.currentUser.uid;

    final result = await users.doc(uid).get();
    return result.data()[type];
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context).current;
    var user = FirebaseAuth.instance.currentUser.email;
    String date = DateFormat("EEEE, MMMM dd, y").format(DateTime.now());
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment(-1.0, -1.5),
                  end: Alignment(1.0, 1.5),
                  colors: [
                    Color(0xff21D4FD),
                    Color(0xffB721FF),
                    Color(0xffFF007C)
                    // Color(0xff2C5364)
                  ],
                  stops: [0.0, 0.5, 1],
                ),
                // boxShadow: [kShadow]
                color: Colors.black,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '   billPRO     ',
                          style: GoogleFonts.getFont('Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome ',
                          style: GoogleFonts.getFont('Montserrat',
                              color: Colors.white, fontSize: 20),
                        ),
                        FutureBuilder(
                          future: getData('company'),
                          builder: (_, snapshot) {
                            _company = snapshot.data;
                            return Container();
                          },
                        ),
                        FutureBuilder(
                          future: getData('address'),
                          builder: (_, snapshot) {
                            _address = snapshot.data;
                            return Container();
                          },
                        ),
                        FutureBuilder(
                          future: getData('pan'),
                          builder: (_, snapshot) {
                            _pan = snapshot.data;
                            return Container();
                          },
                        ),
                        FutureBuilder(
                          future: getData('gst'),
                          builder: (_, snapshot) {
                            _gst = snapshot.data;
                            return Container();
                          },
                        ),
                        FutureBuilder(
                          future: getData('bank'),
                          builder: (_, snapshot) {
                            _bank = snapshot.data;
                            return Container();
                          },
                        ),
                        FutureBuilder(
                          future: getData('ifsc'),
                          builder: (_, snapshot) {
                            _ifsc = snapshot.data;
                            return Container();
                          },
                        ),
                        FutureBuilder(
                          future: getData('accountNumber'),
                          builder: (_, snapshot) {
                            _accountNumber = snapshot.data;
                            return Container();
                          },
                        ),
                        FutureBuilder(
                          future: getData('email'),
                          builder: (_, snapshot) {
                            _email = snapshot.data;
                            Users data = Users(
                              company: _company,
                              address: _address,
                              gst: _gst,
                              email: user,
                              pan: _pan,
                              accountNumber: _accountNumber,
                              ifsc: _ifsc,
                              bank: _bank,
                            );
                            Provider.of<UserData>(context, listen: false)
                                .update(data);
                            return Container();
                          },
                        ),
                        FutureBuilder(
                          future: getData('company'),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                ' ',
                                style: TextStyle(fontSize: 20),
                              );
                            }
                            return Text(
                              snapshot.data,
                              style: GoogleFonts.getFont('Montserrat',
                                  color: Colors.white, fontSize: 20),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(date,
                        style: GoogleFonts.getFont('Montserrat',
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCustomer(),
                      ),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kContainerColor),
                      width: double.infinity,
                      height: 36,
                      child: Text(
                        '+ Customer',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProduct(),
                      ),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kContainerColor),
                      width: double.infinity,
                      height: 36,
                      child: Text(
                        '+ Product',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 350,
            ),
          ],
        ),
      ),
    );
  }
}
