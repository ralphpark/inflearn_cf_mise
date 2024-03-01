import 'package:flutter/material.dart';
import 'package:inflearn_cf_mise/constant/colors.dart';

class MainCard extends StatelessWidget {
  const MainCard({super.key, required this.child, required this.backgroundColor});
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: backgroundColor,
      child: child,
    );
  }
}
