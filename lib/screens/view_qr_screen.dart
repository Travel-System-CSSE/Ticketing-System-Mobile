import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticketing_system/providers/user_provider.dart';
import 'package:ticketing_system/utils/colors.dart';

class ViewQrScreen extends StatelessWidget {
  const ViewQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
        backgroundColor: darkYellow,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data:
                  "{${user.id},{${user.name}, ${user.idNumber}, ${user.role}}",
              size: MediaQuery.of(context).size.width * 0.8,
              gapless: true,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
            ),
          ],
        ),
      ),
    );
  }
}
