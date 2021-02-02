import 'package:bill_pro_v2/screens/update_user.dart';
import 'package:bill_pro_v2/widget/custom_button.dart';
import 'package:bill_pro_v2/widget/custom_container.dart';
import 'package:bill_pro_v2/widget/display_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<String> getData(String type) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    final String uid = FirebaseAuth.instance.currentUser.uid;

    final result = await users.doc(uid).get();
    return result.data()[type];
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: getData('company'),
                          builder: (_, snapshot) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff0F2027),
                                      Color(0xff203A43),
                                      Color(0xff2C5364)
                                    ],
                                    stops: [0.0, 0.5, 1],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? ''
                                        : '${snapshot.data[0]}',
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? ''
                                        : snapshot.data,
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    FirebaseAuth.instance.currentUser.email,
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          height: 45,
                          width: 45,
                          margin: EdgeInsets.only(right: 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateUser(),
                            ),
                          );
                          setState(() {
                            getData('gst');
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        '  Address',
                        style: GoogleFonts.getFont('Montserrat',
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                        future: getData('address'),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return DisplayContainer(' ');
                          }
                          return DisplayContainer(snapshot.data);
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '  GSTIN',
                                  style: GoogleFonts.getFont('Montserrat',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FutureBuilder(
                                  future: getData('gst'),
                                  builder: (_, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return DisplayContainer(' ');
                                    }
                                    return DisplayContainer(snapshot.data);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '  PAN Number',
                                  style: GoogleFonts.getFont('Montserrat',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FutureBuilder(
                                  future: getData('pan'),
                                  builder: (_, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return DisplayContainer(' ');
                                    }
                                    return DisplayContainer(snapshot.data);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        '  Bank',
                        style: GoogleFonts.getFont('Montserrat',
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                        future: getData('bank'),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return DisplayContainer(' ');
                          }
                          return DisplayContainer(snapshot.data);
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '  Account Number',
                                  style: GoogleFonts.getFont('Montserrat',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FutureBuilder(
                                  future: getData('accountNumber'),
                                  builder: (_, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return DisplayContainer(' ');
                                    }
                                    return DisplayContainer(snapshot.data);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '  IFSC',
                                  style: GoogleFonts.getFont('Montserrat',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FutureBuilder(
                                  future: getData('ifsc'),
                                  builder: (_, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return DisplayContainer(' ');
                                    }
                                    return DisplayContainer(snapshot.data);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      width: 115,
                      height: 45,
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Logout',
                            style: GoogleFonts.getFont('Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'billPRO',
                    style: GoogleFonts.getFont('Montserrat',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white24),
                  ),
                  Text('Copyright © Muazzam Faraaz 2021',
                      style: GoogleFonts.getFont('Montserrat',
                          color: Colors.white24)),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
