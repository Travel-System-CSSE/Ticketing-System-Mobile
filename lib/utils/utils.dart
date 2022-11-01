import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String text, {int status = -1}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: status == 1
          ? Colors.green
          : status == 0
              ? Colors.red
              : null,
      content: Text(text),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg'], status: 0);
      break;
    case 401:
      showSnackBar(context, jsonDecode(response.body)['msg'], status: 0);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['msg'], status: 0);
      break;
    default:
      showSnackBar(context, response.body, status: 0);
  }
}

showAlertDialog({
  required BuildContext context,
  required String continueText,
  required String cancelText,
  required String title,
  required String description,
  required VoidCallback continueFunc,
}) {
  Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text(
      cancelText,
      style: GoogleFonts.urbanist(
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
  );

  Widget continueButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
    ),
    onPressed: () => continueFunc(),
    child: Text(
      continueText,
      style: GoogleFonts.urbanist(
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  AlertDialog alert = AlertDialog(
    titlePadding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    title: Text(
      title,
      style: GoogleFonts.urbanist(
        fontWeight: FontWeight.w600,
      ),
    ),
    content: Text(description),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
