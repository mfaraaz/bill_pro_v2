import 'package:bill_pro_v2/models/customer.dart';
import 'package:bill_pro_v2/models/items_list.dart';

class Bill {
  String billNumber;
  String date;
  Customer customer;
  List<ItemsList> items;
  String total;
}
