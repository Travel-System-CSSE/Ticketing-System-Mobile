import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing_system/services/user_services.dart';
import 'package:ticketing_system/utils/colors.dart';
import 'package:ticketing_system/widgets/common/form_field_input.dart';

class UpdatePasswordScreen extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  UpdatePasswordScreen({super.key});

  void updateUserPassword(BuildContext context) {
    UserService().updateUserPassword(
      context: context,
      oldPassword: _oldPasswordController.text,
      newPassword: _newPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Password'),
        backgroundColor: darkYellow,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormFieldInput(
                controller: _oldPasswordController,
                label: 'Current Password',
                hintText: 'current password',
                withAsterisk: true,
                textInputType: TextInputType.text,
                isPass: true,
              ),
              FormFieldInput(
                controller: _newPasswordController,
                label: 'New Password',
                hintText: 'new password',
                withAsterisk: true,
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => updateUserPassword(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: buttonColor,
                ),
                child: Text(
                  'Update Password',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
