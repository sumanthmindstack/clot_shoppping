import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../themes/app_colors.dart';

class InvestmentBreakdown {
  final double sip;
  final double lumpsum;
  final double switchAmount;
  final double redemption;
  final double swp;
  final double stp;

  InvestmentBreakdown({
    required this.sip,
    required this.lumpsum,
    required this.switchAmount,
    required this.redemption,
    required this.swp,
    required this.stp,
  });

  double get total => sip + lumpsum + switchAmount + redemption + swp + stp;

  Map<String, double> getPercentageBreakdown() {
    if (total == 0) {
      return {
        'SIP': 0,
        'Lumpsum': 0,
        'Switch': 0,
        'Redemption': 0,
        'SWP': 0,
        'STP': 0,
      };
    }

    return {
      'SIP': sip / total * 100,
      'Lumpsum': lumpsum / total * 100,
      'Switch': switchAmount / total * 100,
      'Redemption': redemption / total * 100,
      'SWP': swp / total * 100,
      'STP': stp / total * 100,
    };
  }
}

class InvestmentChartWidget extends StatelessWidget {
  final InvestmentBreakdown data;

  const InvestmentChartWidget({
    super.key,
    required this.data,
  });

  static final List<List<Color>> _sectionGradients = [
    [
      AppColors.sipContainerColorCombination1,
      AppColors.sipContainerColorCombination2
    ],
    [
      AppColors.lumpsumContainerColorCombination1,
      AppColors.lumpsumContainerColorCombination2
    ],
    [
      AppColors.switchContainerColorCombination1,
      AppColors.switchContainerColorCombination2
    ],
    [
      AppColors.redeemContainerColorCombination1,
      AppColors.redeemContainerColorCombination2
    ],
    [
      AppColors.swpContainerColorCombination1,
      AppColors.swpContainerColorCombination2
    ],
    [
      AppColors.stpContainerColorCombination1,
      AppColors.stpContainerColorCombination2
    ],
  ];

  static final List<Color> _primaryColors = [
    AppColors.sipContainerColorCombination1,
    AppColors.lumpsumContainerColorCombination1,
    AppColors.switchContainerColorCombination1,
    AppColors.redeemContainerColorCombination1,
    AppColors.swpContainerColorCombination1,
    AppColors.stpContainerColorCombination1,
  ];

  static const List<String> _labels = [
    'SIP',
    'Lumpsum',
    'Switch',
    'Redemption',
    'SWP',
    'STP'
  ];

  @override
  Widget build(BuildContext context) {
    final percentages = data.getPercentageBreakdown();
    final nonZeroEntries =
        percentages.entries.where((e) => e.value > 0).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final chartSize = MediaQuery.of(context).size.width * 0.50;

        return Column(
          children: [
            SizedBox(
              height: chartSize,
              width: chartSize,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: chartSize * 0.20,
                  sectionsSpace: 2,
                  sections: nonZeroEntries.mapIndexed((index, entry) {
                    final colorIndex = _labels.indexOf(entry.key);
                    return PieChartSectionData(
                      value: entry.value,
                      title: '',
                      showTitle: false,
                      radius: chartSize * 0.3,
                      color: _primaryColors[
                          colorIndex], // Using the first color of the gradient pair
                      badgeWidget: _buildLabel(entry.key, entry.value,
                          colorIndex, index, nonZeroEntries.length),
                      badgePositionPercentageOffset: 1.8,
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 70),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: percentages.entries.mapIndexed((index, entry) {
                final colorIndex = _labels.indexOf(entry.key);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 15,
                      height: 12,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: _sectionGradients[colorIndex],
                        ),
                      ),
                    ),
                    Text(
                      entry.key,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLabel(
      String label, double percent, int colorIndex, int index, int total) {
    double verticalOffset = 0;
    if (index == 0) {
      verticalOffset = -12; // Top
    } else if (index == total - 1 || index == total ~/ 2) {
      verticalOffset = 12; // Bottom
    }

    Color labelColor = _primaryColors[colorIndex];

    return Transform.translate(
      offset: Offset(0, verticalOffset),
      child: Text(
        '$label: ${percent.toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: labelColor,
        ),
      ),
    );
  }
}

extension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E item) f) {
    var index = 0;
    return map((e) => f(index++, e));
  }
}
