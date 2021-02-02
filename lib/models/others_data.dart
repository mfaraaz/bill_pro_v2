import '../models/others.dart';
import 'package:flutter/foundation.dart';

class OthersData extends ChangeNotifier {
  Others _current;
  Others get current => _current;

  void update(Others data) {
    _current = data;
    notifyListeners();
  }
}
