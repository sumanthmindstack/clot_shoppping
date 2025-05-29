import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class CustomRichTextField extends StatelessWidget {
  final String normalText;
  final String highlightedText;
  final Color? normalColor;
  final Color? highlightedColor;
  final VoidCallback? onTap;

  const CustomRichTextField({
    Key? key,
    required this.normalText,
    required this.highlightedText,
    this.normalColor,
    this.highlightedColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: normalText,
        style: TextStyle(color: normalColor ?? Colors.black),
        children: [
          TextSpan(
            text: highlightedText,
            style: TextStyle(color: highlightedColor ?? AppColors.primaryColor),
            recognizer:
                onTap != null ? (TapGestureRecognizer()..onTap = onTap) : null,
          ),
        ],
      ),
    );
  }
}
