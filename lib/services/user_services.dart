import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing_system/providers/user_provider.dart';
import 'package:ticketing_system/screens/login_screen.dart';
import 'package:ticketing_system/utils/constants.dart';
import 'package:ticketing_system/utils/utils.dart';

class UserService {
  //! Update User Password
  void updateUserPassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.put(
        Uri.parse('${Constants.uri}/user/update-password'),
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userProvider.user.token}',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, json.decode(res.body)['msg']);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //! Delete User
  void deleteUser(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);

      http.Response res = await http.delete(
        Uri.parse('${Constants.uri}/user/${userProvider.user.id}'),
        headers: <String, String>{
          'Authorization': 'Bearer ${userProvider.user.token}',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser('');
          await prefs.clear();
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
