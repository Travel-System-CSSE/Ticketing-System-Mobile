import 'package:flutter/cupertino.dart';
import 'package:ticketing_system/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    idNumber: '',
    role: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    if (user.isEmpty == false) {
      _user = User.fromJson(user);
    } else {
      _user = User(
        id: '',
        name: '',
        idNumber: '',
        role: '',
        token: '',
      );
    }
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
