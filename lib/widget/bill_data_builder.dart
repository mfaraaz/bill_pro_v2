import 'dart:async';

import 'package:bill_pro_v2/models/customer.dart';
import 'package:bill_pro_v2/models/item_list_data.dart';
import 'package:bill_pro_v2/models/items_list.dart';
import 'package:bill_pro_v2/screens/get_bill.dart';
import 'package:bill_pro_v2/widget/bill_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/customer_data.dart';
import '../widget/cutomer_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillDataBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemList = Provider.of<ItemListData>(context, listen: false).items;
    itemList.clear();
    final uid = FirebaseAuth.instance.currentUser.uid;
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users/$uid/bills')
            .orderBy('billNo')
            .snapshots(),
        builder: (context, billSnapshot) {
          if (billSnapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          final billData = billSnapshot.data.documents;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = billData[index];
              return Column(
                children: [
                  BillTile(
                    name: data['name'],
                    address: data['address'],
                    billNo: data['billNo'],
                    date: data['date'],
                    noItem: data['noItem'].toString(),
                    total: data['total'].toString(),
                    onTap: () {
                      // StreamBuilder(
                      //     stream: FirebaseFirestore.instance
                      //         .collection(
                      //             'users/$uid/bills/${data['billNo']}${data['date']}/items')
                      //         .snapshots(),
                      //     builder: (context, itemSnapshot) {
                      //       if (itemSnapshot.connectionState ==
                      //           ConnectionState.waiting)
                      //         return Center(
                      //           child: Container(),
                      //         );
                      //       final itemData = itemSnapshot.data.documents;
                      //       return ListView.builder(
                      //           itemBuilder: (context, index) {
                      //         final data = itemData[index];
                      //         print(data['name']);
                      //         itemList.add(ItemsList(
                      //             name: data['name'],
                      //             unit: data['unit'],
                      //             hsn: data['hsn'],
                      //             qty: data['qty'],
                      //             price: data['price'],
                      //             total: data['total'],
                      //             note: data['note']));
                      //         return Container(
                      //           child: Text('Hello'),
                      //         );
                      //       });
                      //     });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GetBill(
                              total: data['total'].toString(),
                              pan: data['pan'],
                              noItem: data['noItem'].toString(),
                              name: data['name'],
                              gst: data['gst'],
                              city: data['city'],
                              address: data['address'],
                              date: data['date'],
                              billNo: data['billNo'],
                            ),
                          ));
                    },
                    longPressCallBack: () {
                      print('${data['billNo']}${data['date']}');
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .collection('bills')
                          .doc('${data['billNo']}${data['date']}')
                          .delete();
                    },
                  ),
                ],
              );
            },
            itemCount: billData.length,
          );
        },
      ),
    );
  }
}
