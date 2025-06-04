import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class KYCStatusBanner extends StatelessWidget {
  final bool isCompliant;
  final String? pan;

  const KYCStatusBanner(
      {super.key, required this.isCompliant, required this.pan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isCompliant ? AppColors.primaryGreen : AppColors.errorRed,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isCompliant
            ? "        ${pan}\nYou are KYC compliant"
            : "        ${pan}\nYou are not KYC compliant",
        style: TextStyle(
          backgroundColor:
              isCompliant ? AppColors.primaryGreen : AppColors.errorRed,
          color: AppColors.pureWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
