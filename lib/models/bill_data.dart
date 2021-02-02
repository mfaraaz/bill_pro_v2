import 'dart:collection';

import 'package:bill_pro_v2/models/bill.dart';

import 'package:flutter/foundation.dart';

class BillData extends ChangeNotifier {
  List<Bill> _items = [];

  UnmodifiableListView<Bill> get items => UnmodifiableListView(_items);

  void add(Bill bill) {
    _items.add(bill);
    notifyListeners();
  }

  int get length => _items.length;

  void clear() {
    _items = [];
    notifyListeners();
  }

  void remove(Bill bill) {
    _items.remove(bill);
    notifyListeners();
  }
}
