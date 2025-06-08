import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import '../../../../../../../common/formatters.dart';
import '../../../../../domain/entity/get_scheme_wise_entity.dart';

class SchemeWiseCard extends StatelessWidget {
  final SchemeWiseEntity data;
  final String selectedScale;

  const SchemeWiseCard({
    super.key,
    required this.data,
    required this.selectedScale,
  });

  @override
  Widget build(BuildContext context) {
    final schemeName = Formatters().capitalizeWords(data.schemeName ?? '-');
    final initials = schemeName.isNotEmpty
        ? schemeName.trim().split(' ').map((e) => e[0]).take(2).join()
        : '--';

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
          Row(
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
                      'ISIN: ${data.isin ?? '-'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailLabel(text: 'As on'),
                    SizedBox(height: 8),
                    _DetailLabel(text: 'NAV'),
                    SizedBox(height: 8),
                    _DetailLabel(text: 'Invested Amount'),
                    SizedBox(height: 8),
                    _DetailLabel(text: 'Current Value'),
                    SizedBox(height: 8),
                    _DetailLabel(text: 'Unrealised Gain'),
                    SizedBox(height: 8),
                    _DetailLabel(text: 'Absolute Returns'),
                    SizedBox(height: 8),
                    _DetailLabel(text: 'Units'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildValue(
                        Formatters().formatIsoToNormalDate(data.asOn ?? '')),
                    const SizedBox(height: 8),
                    _buildValue(Formatters().formatWithUnit(
                        num.tryParse(data.nav.toString()) ?? 0, selectedScale)),
                    const SizedBox(height: 8),
                    _buildValue(Formatters().formatWithUnit(
                        num.tryParse(data.investedAmount ?? "0") ?? 0,
                        selectedScale)),
                    const SizedBox(height: 8),
                    _buildValue(Formatters().formatWithUnit(
                        num.tryParse(data.currentValue ?? "0") ?? 0,
                        selectedScale)),
                    const SizedBox(height: 8),
                    _buildValue(Formatters().formatWithUnit(
                        num.tryParse(data.unrealizedGain ?? "0") ?? 0,
                        selectedScale)),
                    const SizedBox(height: 8),
                    _buildValue('${data.absoluteReturn} %'),
                    const SizedBox(height: 8),
                    _buildValue(data.units),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
