import 'package:flutter/material.dart';
import 'package:ticketing_system/utils/colors.dart';

class TravelScreen extends StatelessWidget {
  const TravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travels History'),
        backgroundColor: darkYellow,
        centerTitle: true,
      ),
    );
  }
}
