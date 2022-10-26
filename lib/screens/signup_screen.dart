import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketing_system/widgets/Signup/usertype_card.dart';
import 'package:ticketing_system/widgets/common/custom_textfield.dart';
import 'package:ticketing_system/screens/login_screen.dart';
import 'package:ticketing_system/services/auth_services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  String selectRole = 'Local';

  void signupUser() {
    authService.signUpUser(
      context: context,
      name: nameController.text,
      idNumber: idController.text,
      password: passwordController.text,
      role: selectRole,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Choose account type",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            selectRole = 'Local';
                          }),
                          child: UserTypeCard(
                            role: 'Local',
                            selectRole: selectRole,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            selectRole = 'Foreign';
                          }),
                          child: UserTypeCard(
                            role: 'Foreign',
                            selectRole: selectRole,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(
                      height: 4,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: nameController,
                      label: 'Name',
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: idController,
                      label: selectRole == 'Local'
                          ? 'NIC Number'
                          : 'Passport Number',
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: passwordController,
                      label: 'Password',
                      isPass: true,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: signupUser,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.white),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 50),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const Spacer(flex: 2),
                    RichText(
                      text: TextSpan(
                        text: 'Do you have an account?',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: ' Sign in',
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
