import 'package:amazon_clone/src/models/user/user.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
