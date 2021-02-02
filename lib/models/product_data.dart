import 'dart:collection';

import '../models/product.dart';
import 'package:flutter/foundation.dart';

class ProductData extends ChangeNotifier {
  List<Product> _items = [
    Product(name: 'Name', hsn: '0000', unit: 'ut', index: '0'),
    // Product(
    //     name: 'Dupatta: Jaquard Dark', hsn: '5210', unit: 'pcs', index: '1'),
    // Product(
    //     name: 'Dupatta: Jaquard Multi', hsn: '5210', unit: 'pcs', index: '2'),
    // Product(
    //     name: 'Dupatta: Jaquard Matching',
    //     hsn: '5210',
    //     unit: 'pcs',
    //     index: '3'),
    // Product(name: 'Than: Jaquard Light', hsn: '5407', unit: 'mtr', index: '4'),
    // Product(name: 'Than: Jaquard Dark', hsn: '5407', unit: 'mtr', index: '5'),
    // Product(name: 'Than: Jaquard Multi', hsn: '5407', unit: 'mtr', index: '6'),
    // Product(
    //     name: 'Than: Check Zari Boota', hsn: '5407', unit: 'mtr', index: '7'),
  ];

  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  int get length => _items.length;

  void clear() {
    _items = [Product(name: 'Name', hsn: '0000', unit: 'ut', index: '0')];
    notifyListeners();
  }

  void remove(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}
