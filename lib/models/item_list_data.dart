import 'dart:collection';
import '../models/items_list.dart';
import 'package:flutter/foundation.dart';

class ItemListData extends ChangeNotifier {
  List<ItemsList> items = [];

  // UnmodifiableListView<ItemsList> get items => UnmodifiableListView(_items);

  void add(ItemsList itemsList) {
    items.add(itemsList);
    notifyListeners();
  }

  int get length => items.length;

  double getTotal() {
    if (items.isNotEmpty)
      return items.map((e) => e.total).reduce((a, b) => a + b);
    return 0.0;
  }

  void remove(ItemsList itemsList) {
    items.remove(itemsList);
    notifyListeners();
  }

  void removeAll() {
    items.clear();
    notifyListeners();
  }
}
