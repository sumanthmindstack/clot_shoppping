import 'package:clot_store/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BasicAppButton extends StatelessWidget {
  final String? title;
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  final Color? color;
  const BasicAppButton(
      {super.key,
      this.title,
      this.width,
      this.height,
      required this.onPressed,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryColor,
          minimumSize:
              Size(width ?? MediaQuery.sizeOf(context).width, height ?? 50)),
      child: Text(
        title ?? "---",
        style: TextStyle(color: AppColors.pureWhiteColor, fontSize: 16),
      ),
    );
  }
}
