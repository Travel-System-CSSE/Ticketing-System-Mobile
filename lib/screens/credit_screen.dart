import 'package:flutter/material.dart';
import 'package:ticketing_system/utils/colors.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
        backgroundColor: darkYellow,
        centerTitle: true,
      ),
    );
  }
}
