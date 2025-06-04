import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final double widthFactor;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;

  const CustomTextButton({
    super.key,
    required this.text,
    this.widthFactor = 0.2,
    this.onTap,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.textColor = const Color(0xFF6200EE),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: MediaQuery.sizeOf(context).width * widthFactor,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
