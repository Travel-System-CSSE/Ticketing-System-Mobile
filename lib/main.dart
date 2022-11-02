import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/providers/credit_provider.dart';
import 'package:ticketing_system/providers/user_provider.dart';
import 'package:ticketing_system/screens/signup_screen.dart';
import 'package:ticketing_system/services/auth_services.dart';
import 'package:ticketing_system/widgets/common/root_navigation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey =
      'pk_test_51LzQlJD1dVzqQ9BqX57N9LsU0Omb3LYSBtIkzOmnkfJVERecmJQ6o3BnTQhR2auPeibm08EmtwLEZuwQPcDu8Nrf000JOGJShW';
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreditProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.isUserLogged(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketing System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Provider.of<UserProvider>(context).user.token.isEmpty
          ? const SignupScreen()
          : const RootNavigation(),
    );
  }
}
