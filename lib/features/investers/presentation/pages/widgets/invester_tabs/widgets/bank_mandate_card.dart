import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import '../../../../../domain/entity/get_bank_mandates_entity.dart';
import '../../../../../../../common/formatters.dart';

class BankMandateCard extends StatelessWidget {
  final BankMandateEntity data;

  const BankMandateCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          _buildDetailsRow(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            Formatters().capitalizeWords(data.providerName),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        data.providerName.isNotEmpty == true
            ? data.providerName![0].toUpperCase()
            : '?',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildDetailsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailLabel(text: 'Mandate Type'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Mandate Limit'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Account Holder'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Account Number'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Bank Name'),
              SizedBox(height: 8),
              _DetailLabel(text: 'IFSC Code'),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildValue(data.mandateType),
              const SizedBox(height: 8),
              _buildValue(Formatters().formatIndianCurrency(data.mandateLimit)),
              const SizedBox(height: 8),
              _buildValue(data.userBankDetail.accountHolderName),
              const SizedBox(height: 8),
              _buildValue(data.userBankDetail.accountNumber),
              const SizedBox(height: 8),
              _buildValue(data.userBankDetail.bankName),
              const SizedBox(height: 8),
              _buildValue(data.userBankDetail.ifscCode),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValue(String? value) {
    return Text(
      value ?? '-',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade900,
      ),
    );
  }
}

class _DetailLabel extends StatelessWidget {
  final String text;

  const _DetailLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade600,
      ),
    );
  }
}
