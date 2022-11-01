import 'package:flutter/cupertino.dart';
import 'package:ticketing_system/screens/credit_screen.dart';
import 'package:ticketing_system/screens/home_screen.dart';
import 'package:ticketing_system/screens/profile_screen.dart';
import 'package:ticketing_system/screens/travel_screen.dart';
import 'package:ticketing_system/screens/view_qr_screen.dart';

List<Widget> homeScreenItems = [
  const HomeScreen(),
  CreditScreen(),
  const ViewQrScreen(),
  const TravelScreen(),
  const ProfileScreen(),
];
