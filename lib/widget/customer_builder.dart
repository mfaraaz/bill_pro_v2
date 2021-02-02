import 'package:bill_pro_v2/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/customer_data.dart';
import '../widget/cutomer_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users/$uid/customer')
          .orderBy('name')
          .snapshots(),
      builder: (context, customerSnapshot) {
        if (customerSnapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        final customerDocs = customerSnapshot.data.documents;
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final data = customerDocs[index];
            return CustomerTile(
              name: data['name'],
              address: data['address'],
              index: data['index'],
              longPressCallBack: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection('customer')
                    .doc('${data['name']}${data['gst']}')
                    .delete();
              },
            );
          },
          itemCount: customerDocs.length,
        );
      },
    );
  }
}
