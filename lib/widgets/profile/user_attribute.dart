import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing_system/utils/colors.dart';

class UserAttribute extends StatelessWidget {
  final String attributeName;
  final String attributeValue;

  const UserAttribute({
    super.key,
    required this.attributeName,
    required this.attributeValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 6),
            child: Text(
              attributeName,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: textContainerColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              attributeValue,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: greyTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
