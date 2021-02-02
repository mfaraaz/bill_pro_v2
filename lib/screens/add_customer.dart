import 'package:bill_pro_v2/widget/custom_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/customer.dart';
import '../models/customer_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name, address, pan, gst, city;
    final nameController = TextEditingController();
    final addController = TextEditingController();
    final panController = TextEditingController();
    final gstController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        shadowColor: Color(0xff),
        title: Container(
          child: Text(
            'NEW CUSTOMER',
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomContainer(
                  child: TextField(
                    controller: nameController,
                    style: GoogleFonts.getFont('Montserrat'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter Name',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomContainer(
                  child: TextField(
                    controller: addController,
                    style: GoogleFonts.getFont('Montserrat'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter Address',
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
                    style: GoogleFonts.getFont('Montserrat'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter City',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      city = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomContainer(
                  child: TextField(
                    controller: panController,
                    style: GoogleFonts.getFont('Montserrat'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter Pan',
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
                    controller: gstController,
                    style: GoogleFonts.getFont('Montserrat'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter GST',
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
                      'Submit',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    onPressed: () {
                      final uid = FirebaseAuth.instance.currentUser.uid;
                      FirebaseFirestore.instance
                          .collection('users/$uid/customer')
                          .doc('$name$gst')
                          .set({
                        'name': name,
                        'address': address,
                        'city': city,
                        'gst': gst,
                        'pan': pan,
                        'index':
                            Provider.of<CustomerData>(context, listen: false)
                                .length
                                .toString(),
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
