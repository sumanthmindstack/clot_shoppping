import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../../../../../../../common/formatters.dart';
import '../../../../../domain/entity/get_holding_details_entity.dart';

class HoldingsCard extends StatelessWidget {
  final SchemeEntity data;
  final String selectedScale;

  const HoldingsCard({
    super.key,
    required this.data,
    required this.selectedScale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Container(
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
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSchemeAvatar(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                'Folio: ${data.isin}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSchemeAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        data.name[0].toUpperCase(),
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
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailLabel(text: 'Total Units'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Redeemable Units'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Invested Amount'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Redeemable Amount'),
              SizedBox(height: 8),
              _DetailLabel(text: 'As on'),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildDetailValue(data.holdings.redeemableUnits.toString()),
              const SizedBox(height: 8),
              _buildDetailValue(data.holdings.redeemableUnits.toString()),
              const SizedBox(height: 8),
              _buildDetailValue(data.investedValue.amount.toString(),
                  isFormattedUnit: true),
              const SizedBox(height: 8),
              _buildDetailValue(data.marketValue.redeemableAmount.toString(),
                  isFormattedUnit: true),
              const SizedBox(height: 8),
              _buildDetailValue(
                  Formatters().formatIsoToNormalDate(data.nav.asOn),
                  isFormattedDate: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailValue(
    String value, {
    bool isHighlighted = false,
    bool isFormattedUnit = false,
    bool isFormattedDate = false,
  }) {
    final sanitizedValue = _sanitizeNumber(value);

    final displayValue = isFormattedUnit
        ? Formatters().formatWithUnit(num.parse(sanitizedValue), selectedScale)
        : (num.tryParse(sanitizedValue) != null
            ? Formatters().formatTwoDecimals(num.parse(sanitizedValue))
            : value);

    return Text(
      displayValue,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: isHighlighted ? Colors.green.shade700 : Colors.grey.shade900,
      ),
    );
  }

  String _sanitizeNumber(String input) {
    return input.replaceAll(RegExp(r'[^\d.-]'), '');
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
