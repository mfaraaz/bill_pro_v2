import 'package:bill_pro_v2/models/customer.dart';
import 'package:bill_pro_v2/models/customer_data.dart';
import 'package:bill_pro_v2/widget/custom_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/add_product.dart';

import '../models/item_list_data.dart';
import '../models/items_list.dart';
import '../models/product.dart';
import '../models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddItemList extends StatefulWidget {
  @override
  _AddItemListState createState() => _AddItemListState();
}

class _AddItemListState extends State<AddItemList> {
  final uid = FirebaseAuth.instance.currentUser.uid;
  String selectedItem = '0';
  @override
  Widget build(BuildContext context) {
    String name, unit, hsn, note = 'sample';
    double qty, price, total;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        shadowColor: Color(0xff),
        title: Container(
          child: Text(
            'NEW ITEM',
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users/$uid/product')
                      .orderBy('name')
                      .snapshots(),
                  builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState ==
                        ConnectionState.waiting)
                      return Center(
                        child: Container(),
                      );
                    Provider.of<ProductData>(context, listen: false).clear();
                    final productDocs = productSnapshot.data.documents;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = productDocs[index];
                        Product product = Product(
                            name: data['name'],
                            hsn: data['hsn'],
                            unit: data['unit'],
                            index:
                                Provider.of<ProductData>(context, listen: false)
                                    .length
                                    .toString());
                        Provider.of<ProductData>(context, listen: false)
                            .add(product);
                        return Container();
                      },
                      itemCount: productDocs.length,
                    );
                  },
                ),
                Consumer<ProductData>(
                  builder: (context, productData, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomContainer(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                            ),
                            value: selectedItem,
                            items: productData.items.map((Product item) {
                              return DropdownMenuItem<String>(
                                child: Text('${item.name}'),
                                value: item.index,
                              );
                            }).toList(),
                            onChanged: (String string) => setState(() {
                              selectedItem = string;
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomContainer(
                          child: TextField(
                            style: GoogleFonts.getFont('Montserrat'),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Enter Price',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            onChanged: (value) {
                              price = double.parse(value);
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
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Enter Qty',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            onChanged: (value) {
                              qty = double.parse(value);
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
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Extra',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            onChanged: (value) {
                              note = value;
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
                              ItemsList itemsList = ItemsList(
                                name: productData
                                    .items[int.parse(selectedItem)].name,
                                unit: productData
                                    .items[int.parse(selectedItem)].unit,
                                hsn: productData
                                    .items[int.parse(selectedItem)].hsn,
                                qty: qty,
                                price: price,
                                total: price * qty,
                                note: note,
                              );
                              Provider.of<ItemListData>(context, listen: false)
                                  .add(itemsList);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 250,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct(),
            ),
          );
        },
      ),
    );
  }
}
