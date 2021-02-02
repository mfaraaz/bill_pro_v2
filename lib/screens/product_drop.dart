import '../models/product.dart';
import '../models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductDrop extends StatefulWidget {
  ProductDrop({this.name, this.unit, this.hsn});
  String name, hsn, unit;
  @override
  _ProductDropState createState() => _ProductDropState();
}

class _ProductDropState extends State<ProductDrop> {
  String selectedItem = '1';
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductData>(
      builder: (context, productData, child) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          ),
          value: selectedItem,
          // selectedItemBuilder: (BuildContext context) {
          //   return dataNot.items.map<Widget>((Data item) {
          //     return Text(item.title);
          //   }).toList();
          // },
          items: productData.items.map((Product item) {
            return DropdownMenuItem<String>(
              child: Text('${item.name}'),
              value: item.index,
            );
          }).toList(),
          onChanged: (String string) => setState(() {
            selectedItem = string;
            widget.name = productData.items[int.parse(selectedItem)].name;
            widget.hsn = productData.items[int.parse(selectedItem)].name;
          }),
        );
      },
    );
  }
}
