import 'package:bill_pro_v2/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product_data.dart';
import '../widget/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductBuilder extends StatelessWidget {
  final uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users/$uid/product')
          .orderBy('name')
          .snapshots(),
      builder: (context, productSnapshot) {
        if (productSnapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        final productDocs = productSnapshot.data.documents;
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final data = productDocs[index];

            return ProductTile(
              name: data['name'],
              hsn: data['hsn'],
              longPressCallBack: () async {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection('product')
                    .doc('${data['name']}${data['hsn']}')
                    .delete();
              },
            );
          },
          itemCount: productDocs.length,
        );
      },
    );
  }
}
