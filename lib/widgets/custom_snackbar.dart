import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    EdgeInsets margin = const EdgeInsets.all(16),
    double borderRadius = 12.0,
    Duration duration = const Duration(seconds: 4),
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
        behavior: behavior,
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
