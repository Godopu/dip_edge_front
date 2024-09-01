import 'package:dip_edge_front/colors.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final void Function() onTap;
  const ProfileCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.white10,
          ),
        ),
        child: const Center(
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}
