import 'package:flutter/material.dart';

class CustomLoadingButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const CustomLoadingButton({
    super.key,
    this.width = double.infinity,
    this.height = 50.0,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(color),
          backgroundColor: WidgetStatePropertyAll(color),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onPressed: null,
        child: const SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
