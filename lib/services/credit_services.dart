import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ticketing_system/providers/credit_provider.dart';
import 'package:ticketing_system/providers/user_provider.dart';
import 'package:ticketing_system/utils/constants.dart';
import 'package:ticketing_system/utils/utils.dart';

class CreditService {
  Map<String, dynamic>? paymentIntent;

  //! Make Payment
  void makePayment(
    BuildContext context,
    String amount,
    String currency,
  ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      paymentIntent = await createPaymentIntent(context, amount, currency);
      debugPrint(paymentIntent.toString());
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: userProvider.user.name,
        ),
      );

      //! Payment Success Code
      await Stripe.instance.presentPaymentSheet().then((value) async {
        showSnackBar(context, 'Payment Successfull', status: 1);
        await http.post(
          Uri.parse('${Constants.uri}/credit'),
          body: jsonEncode({
            'idNumber': userProvider.user.idNumber,
            'amount': int.parse(amount),
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        paymentIntent = null;
      });

      //! Payment Failed Code
    } on StripeException catch (e) {
      showSnackBar(context, 'Payment Cancelled');
    } catch (e) {
      showSnackBar(context, e.toString(), status: 0);
    }
  }

  //! Create Payment Intent
  createPaymentIntent(
    BuildContext context,
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${dotenv.env['SECRET_KEY']}',
            'Content-Type': 'application/x-www-form-urlencoded',
          });

      return jsonDecode(response.body);
    } catch (e) {
      showSnackBar(context, e.toString(), status: 0);
    }
  }

  //! Convert Cent to Actual Value
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  //! Get Account Balance
  void getBalance(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var creditProvider = Provider.of<CreditProvider>(context, listen: false);

      http.Response res = await http.get(
        Uri.parse('${Constants.uri}/credit/${userProvider.user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          creditProvider.setBalance(
              (json.decode(res.body) as Map<String, dynamic>)['balance']);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), status: 0);
    }
  }
}
