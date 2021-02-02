import 'package:bill_pro_v2/widget/custom_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product.dart';
import '../models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name, hsn, unit;
    final nameController = TextEditingController();
    final hsnController = TextEditingController();
    final unitController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        shadowColor: Color(0xff),
        title: Container(
          child: Text(
            'NEW PRODUCT',
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
                    controller: hsnController,
                    style: GoogleFonts.getFont('Montserrat'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter HSN',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      hsn = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomContainer(
                  child: TextField(
                    controller: unitController,
                    style: GoogleFonts.getFont('Montserrat'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter Unit',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) {
                      unit = value;
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
                          .collection('users/$uid/product')
                          .doc('$name$hsn')
                          .set({
                        'name': name,
                        'hsn': hsn,
                        'unit': unit,
                        'index':
                            Provider.of<ProductData>(context, listen: false)
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
