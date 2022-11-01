import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/providers/user_provider.dart';
import 'package:ticketing_system/screens/update_password_screen.dart';
import 'package:ticketing_system/services/auth_services.dart';
import 'package:ticketing_system/services/user_services.dart';
import 'package:ticketing_system/utils/colors.dart';
import 'package:ticketing_system/utils/utils.dart';
import 'package:ticketing_system/widgets/profile/optionsTile.dart';
import 'package:ticketing_system/widgets/profile/user_attribute.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void signOutUser(BuildContext context) {
    AuthService().signOut(context);
  }

  void deleteUser(BuildContext context) {
    showAlertDialog(
      context: context,
      title: "Delete Account",
      description: "Are you sure you want to delete this account?",
      cancelText: "Cancel",
      continueText: "Delete",
      continueFunc: () {
        UserService().deleteUser(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: darkYellow,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAttribute(
                attributeName: 'Name',
                attributeValue: user.name,
              ),
              UserAttribute(
                attributeName:
                    user.role == 'local' ? 'NIC Number' : 'Passport Number',
                attributeValue: user.idNumber,
              ),
              UserAttribute(
                attributeName: 'Role',
                attributeValue: '${user.role} User'.capitalize(),
              ),
              const Divider(),
              OptionTile(
                leadingIcon: Icons.password_rounded,
                title: 'Update Password',
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdatePasswordScreen(),
                    ),
                  );
                },
              ),
              OptionTile(
                leadingIcon: Icons.no_accounts,
                title: 'Delete Account',
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => deleteUser(context),
              ),
              OptionTile(
                leadingIcon: Icons.logout_rounded,
                title: 'Log out',
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => signOutUser(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
