import 'dart:collection';
import '../models/customer.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerData extends ChangeNotifier {
  // CustomerData() {
  //   setup();
  // }

  // void setup() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final List<Customer> items = (await prefs.get('list') ?? []);
  //   _items = items;
  //   notifyListeners();
  // }

  // void saveData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('list', ['hey', 'wor']);
  // }

  List<Customer> _items = [
    Customer(
        name: 'NAME', pan: '-', gst: '-', address: '-', city: ' ', index: '0')
  ];

  UnmodifiableListView<Customer> get items => UnmodifiableListView(_items);

  void add(Customer customer) {
    _items.add(customer);
    notifyListeners();
  }

  void clear() {
    _items = [
      Customer(
          name: 'NAME', pan: '-', gst: '-', address: '-', city: ' ', index: '0')
    ];
    notifyListeners();
  }

  double getIndex(Customer customer) {
    return _items.indexOf(customer) / length;
  }

  int get length => _items.length;

  void remove(Customer customer) {
    _items.remove(customer);
    notifyListeners();
  }
}
