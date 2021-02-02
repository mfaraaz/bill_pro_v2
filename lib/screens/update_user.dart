import 'package:bill_pro_v2/models/user_data.dart';
import 'package:bill_pro_v2/widget/custom_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserData>(context).current;
    String bank = '',
        address = '',
        pan = '',
        gst = '',
        email = '',
        ifsc = '',
        accountNumber = '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        shadowColor: Color(0xff),
        title: Container(
          child: Text(
            'UPDATE USER',
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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomContainer(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white12,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Address',
                      hintStyle: GoogleFonts.getFont('Montserrat'),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      address = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomContainer(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white12,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'GST',
                      hintStyle: GoogleFonts.getFont('Montserrat'),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      gst = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomContainer(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white12,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'PAN',
                      hintStyle: GoogleFonts.getFont('Montserrat'),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      pan = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomContainer(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white12,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Account Number',
                      hintStyle: GoogleFonts.getFont('Montserrat'),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      accountNumber = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomContainer(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white12,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Bank',
                      hintStyle: GoogleFonts.getFont('Montserrat'),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      bank = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomContainer(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white12,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'IFSC',
                      hintStyle: GoogleFonts.getFont('Montserrat'),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      ifsc = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: 60,
                  child: FlatButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    onPressed: () async {
                      final CollectionReference users =
                          FirebaseFirestore.instance.collection('users');
                      final String uid = FirebaseAuth.instance.currentUser.uid;
                      // final result = await users.doc(uid).get();
                      if (email != '')
                        await users.doc(uid).update({'email': email});
                      if (bank != '') {
                        data.bank = bank;
                        await users.doc(uid).update({'bank': bank});
                      }
                      if (gst != '') {
                        data.gst = gst;
                        await users.doc(uid).update({'gst': gst});
                      }
                      if (pan != '') {
                        data.pan = pan;
                        await users.doc(uid).update({'pan': pan});
                      }
                      if (ifsc != '') {
                        data.ifsc = ifsc;
                        await users.doc(uid).update({'ifsc': ifsc});
                      }
                      if (accountNumber != '') {
                        data.accountNumber = accountNumber;
                        await users
                            .doc(uid)
                            .update({'accountNumber': accountNumber});
                      }
                      if (address != '') {
                        data.address = address;
                        await users.doc(uid).update({'address': address});
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '**Change only the values that needs to be updated**',
                  style: GoogleFonts.getFont('Montserrat',
                      color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
