import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class CodeTextfield extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const CodeTextfield({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.number,
    required this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hintText),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 12),
    );
  }
}
