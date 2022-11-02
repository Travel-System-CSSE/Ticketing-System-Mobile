import 'package:flutter/cupertino.dart';

class CreditProvider extends ChangeNotifier {
  int _balance = 0;

  int get balance => _balance;

  void setBalance(int balance) {
    _balance = balance;
    notifyListeners();
  }
}
