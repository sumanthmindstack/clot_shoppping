import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import '../../../../../../../common/formatters.dart';
import '../../../../../domain/entity/get_capital_gains_entity.dart';

class CapitalGainsCard extends StatelessWidget {
  final CapitalGainEntity data;
  final String selectedScale;

  const CapitalGainsCard({
    super.key,
    required this.data,
    required this.selectedScale,
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
    final schemeName = Formatters().capitalizeWords(data.schemeName ?? '-');
    final initials = schemeName.isNotEmpty
        ? schemeName.trim().split(' ').map((e) => e[0]).take(2).join()
        : '--';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.2),
          radius: 20,
          child: Text(
            initials,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                schemeName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Folio: ${data.folioNumber}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'ISIN: ${data.isin}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
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
              _DetailLabel(text: 'Type'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Purchased On'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Units'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Amount'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Days Held'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Purchased At'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Traded On'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Traded At'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Actual Gains'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Taxable Gain'),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildValue(data.type),
              const SizedBox(height: 8),
              _buildValue(Formatters()
                  .formatIsoToReadableDate(data.sourcePurchasedOn.toString())),
              const SizedBox(height: 8),
              _buildValue(data.units),
              const SizedBox(height: 8),
              _buildValue(Formatters().formatWithUnit(
                  num.parse(data.amount.toString()), selectedScale)),
              const SizedBox(height: 8),
              _buildValue(data.sourceDaysHeld.toString()),
              const SizedBox(height: 8),
              _buildValue(Formatters().formatWithUnit(
                  num.parse(data.sourcePurchasedAt ?? '0'), selectedScale)),
              const SizedBox(height: 8),
              _buildValue(data.tradedOn),
              const SizedBox(height: 8),
              _buildValue(Formatters().formatWithUnit(
                  num.parse(data.tradedAt ?? "0"), selectedScale)),
              const SizedBox(height: 8),
              _buildValue(Formatters().formatWithUnit(
                  num.parse(data.sourceActualGain ?? "0"), selectedScale)),
              const SizedBox(height: 8),
              _buildValue(Formatters().formatWithUnit(
                  num.parse(data.sourceTaxableGain ?? "0"), selectedScale)),
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
