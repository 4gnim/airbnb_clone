import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton(
      {super.key,
      required this.icon,
      this.radius,
      this.color = Colors.white,
      this.iconColor = Colors.black});

  final IconData icon;
  final double? radius;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
