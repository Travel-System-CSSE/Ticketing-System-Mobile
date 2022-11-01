import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing_system/providers/user_provider.dart';
import 'package:ticketing_system/screens/login_screen.dart';
import 'package:ticketing_system/utils/constants.dart';
import 'package:ticketing_system/utils/utils.dart';
import 'package:ticketing_system/widgets/common/root_navigation.dart';

class AuthService {
  //! Sign Up User
  void signUpUser({
    required BuildContext context,
    required String name,
    required String idNumber,
    required String password,
    required String role,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/auth/register'),
        body: jsonEncode({
          'name': name,
          'idNumber': idNumber,
          'password': password,
          'role': role.toLowerCase(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString('userData', res.body);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const RootNavigation(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), status: 0);
    }
  }

  //! Sign In User
  void signInUser({
    required BuildContext context,
    required String idNumber,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/auth/login'),
        body: jsonEncode({
          'idNumber': idNumber,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString('userData', res.body);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const RootNavigation(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), status: 0);
    }
  }

  //! Sign Out User
  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  //! Is User Logged
  void isUserLogged(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userData = prefs.getString('userData');
      if (userData != null) {
        userProvider.setUser(userData);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), status: 0);
    }
  }
}
