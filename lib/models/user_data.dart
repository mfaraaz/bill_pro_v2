import '../models/user.dart';
import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier {
  Users current;
  // Users get current => _current;

  void update(Users data) {
    current = data;
    notifyListeners();
  }

  void changeTheme() {
    current.theme = !current.theme;
  }
}
