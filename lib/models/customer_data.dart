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
        name: 'NAME', pan: '-', gst: '-', address: '-', city: ' ', index: '0'),
    // Customer(
    //     name: 'Asian Fabrics',
    //     pan: 'AEVPK1674B',
    //     gst: '07AEVPK1674B1ZE',
    //     address: '652-655, Katra Hardayal Nai Sarak ',
    //     city: 'Ch. Chowk	Delhi-6',
    //     index: '1'),
    // Customer(
    //     name: 'HARI TEX',
    //     pan: 'AKNPR9198R',
    //     gst: '24AKNPR9198R1ZQ',
    //     address: 'S-1388-89 First Floor New Textile Market	',
    //     city: 'Ring Road, Surat',
    //     index: '2'),
    // Customer(
    //     name: 'K. Rudra Fashion',
    //     pan: 'AMUPK0957E',
    //     gst: '24AMUPK0957E1ZW',
    //     address: 'Shop No.109,1st Floor,A-One Market,Keroshinegali',
    //     city: 'Kalupur Railway Station,Ahmedabad-380002',
    //     index: '3'),
    // Customer(
    //     name: 'Khodiyar Dresses',
    //     pan: 'ACZPL0757A',
    //     gst: '24ACZPL0757A1ZL',
    //     address: 'F-614:15,Upper Ground,New Textile Market',
    //     city: 'Ring Road, Surat',
    //     index: '4'),
    // Customer(
    //     name: 'Khodiyar Dress Materials',
    //     pan: 'AAPFK3638K',
    //     gst: '24AAPFK3638K1ZY',
    //     address: '1014,Kashi Market	Ring Road, Surat',
    //     index: '5'),
    // Customer(
    //     name: 'L.T.Fabrics',
    //     pan: 'AACPR0839C',
    //     gst: '24AACPR0839C1Z3',
    //     address: 'E-594,New Textile Market	Ring Road, Surat',
    //     index: '6'),
    // Customer(
    //     name: 'Maa Sharda Fabric Traders',
    //     pan: 'BONPS1268A',
    //     gst: '07BONPS1268A1ZW',
    //     address: 'Shop No.356,1st Floor,Kucha Ghasi Ram	',
    //     city: 'Chandni Chowk, Delhi-6',
    //     index: '7'),
    // Customer(
    //     name: 'Om Prakash & Sons',
    //     pan: 'AAAFO0370R',
    //     gst: '07AAAFO0370R1Z0',
    //     address: '5486, Chandni Chowk, (Opp. Town Hall)',
    //     city: 'Delhi - 110006',
    //     index: '8'),
    // Customer(
    //     name: 'Sadhna Silk Mills',
    //     pan: 'ACUPK0294Q',
    //     gst: '24ACUPK0294Q1ZU',
    //     address: 'Q-1341-44, New Textile Market	Ring Road, Surat',
    //     index: '9'),
    // Customer(
    //     name: 'Shree Gajanand Textile',
    //     pan: 'AREPN6428J',
    //     gst: '24AREPN6428J1ZM',
    //     address: 'U.G.R Floor,Wing-E Shop No.600-601 New Textile Market',
    //     city: 'Begampura Surat, Gujarat-395003',
    //     index: '10'),
    // Customer(
    //     name: 'Shree Om Fashion',
    //     pan: 'ADYPK4600K',
    //     gst: '24ADYPK4600K1ZA',
    //     address: 'S-1383-86,1st Floor,New Textile Market	',
    //     city: 'Ring Road, Surat',
    //     index: '11'),
    // Customer(
    //     name: 'Shri_Durga_Traders_Co',
    //     pan: 'AEHPK3375M',
    //     gst: '07AEHPK3775M1ZZ',
    //     address: '676 First Floor, Gali Ghanteshwar, Katra Neel,',
    //     city: 'Ch. Chowk	Central Delh, Delhi, 110006',
    //     index: '12'),
    // Customer(
    //     name: 'Sapna Dupattas',
    //     pan: 'AAMPK7518H',
    //     gst: '07AAMPK7518H1ZG',
    //     address: '5570-B,Nai Sarak Chandni Chowk',
    //     city: 'Delhi-06',
    //     index: '13'),
    // Customer(
    //     name: 'Asian_Fabrics_2019-20',
    //     pan: 'BJVPK1037N',
    //     gst: '07BJVPK1037N1ZO',
    //     address: '652-655, Katra Hardayal Nai Sarak Ch. Chowk',
    //     city: 'Delhi-6',
    //     index: '14'),
    // Customer(
    //     name: 'Pallavi_Sarees',
    //     pan: 'AAAFP0161B',
    //     gst: '07AAAFP0161B1ZZ',
    //     address: '340 ,Katra Naya ,Chandni Chowk',
    //     city: 'Delhi-6',
    //     index: '15'),
    // Customer(
    //     name: 'Yameen Creation',
    //     pan: 'AEVPH2407K',
    //     gst: '08AEVPH2407K1Z7',
    //     address: '52, Ramganj Bazar',
    //     city: 'Jaipur',
    //     index: '16'),
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
