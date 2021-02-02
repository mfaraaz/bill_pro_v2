import '../models/item_list_data.dart';
import '../widget/item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemListData>(builder: (context, itemList, child) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final data = itemList.items[index];
          return ItemListTile(
            name: data.name,
            hsn: data.hsn,
            unit: data.unit,
            qty: data.qty,
            total: data.total,
            price: data.price,
            longPressCallBack: () {
              itemList.remove(data);
            },
          );
        },
        itemCount: itemList.length,
      );
    });
  }
}
