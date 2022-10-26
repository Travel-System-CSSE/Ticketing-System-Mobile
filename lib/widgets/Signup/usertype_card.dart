import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserTypeCard extends StatelessWidget {
  final String role;
  final String selectRole;

  const UserTypeCard({
    super.key,
    required this.role,
    required this.selectRole,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (role == selectRole)
          const Positioned(
            bottom: -4,
            right: -4,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.done_rounded,
                color: Colors.white,
              ),
            ),
          ),
        Container(
          width: 165,
          height: 165,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                'assets/${role.toLowerCase()}.svg',
                height: 110,
              ),
              Text(
                '$role User',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
