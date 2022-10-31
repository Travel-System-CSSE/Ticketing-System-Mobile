import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing_system/utils/colors.dart';

class FormFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool withAsterisk;
  final TextInputType textInputType;
  final bool isPass;
  final Icon? suffixIcon;

  const FormFieldInput({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.withAsterisk,
    required this.textInputType,
    this.isPass = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 1),
            child: RichText(
              text: TextSpan(
                text: label,
                style: GoogleFonts.urbanist(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: withAsterisk ? ' *' : '',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: textContainerColor,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: greyTextColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: buttonColor,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              suffixIcon: suffixIcon,
            ),
            textInputAction: TextInputAction.next,
            keyboardType: textInputType,
            obscureText: isPass,
            validator: (value) {
              if (withAsterisk && value!.isEmpty) {
                return 'Please enter a $hintText.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
