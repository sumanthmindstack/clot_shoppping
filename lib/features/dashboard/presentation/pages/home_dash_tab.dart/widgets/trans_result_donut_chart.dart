import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../../../../../themes/app_colors.dart';

class InvestmentBreakdown {
  // Transaction fields
  final double sip;
  final double lumpsum;
  final double switchAmount;
  final double redemption;
  final double swp;
  final double stp;

  // AUM fields
  final double equity;
  final double debt;
  final double hybrid;
  final double alternate;

  final bool isAum;

  InvestmentBreakdown._({
    required this.sip,
    required this.lumpsum,
    required this.switchAmount,
    required this.redemption,
    required this.swp,
    required this.stp,
    required this.equity,
    required this.debt,
    required this.hybrid,
    required this.alternate,
    required this.isAum,
  });

  /// Create for Transaction data
  factory InvestmentBreakdown.transaction({
    required double sip,
    required double lumpsum,
    required double switchAmount,
    required double redemption,
    required double swp,
    required double stp,
  }) {
    return InvestmentBreakdown._(
      sip: sip,
      lumpsum: lumpsum,
      switchAmount: switchAmount,
      redemption: redemption,
      swp: swp,
      stp: stp,
      equity: 0,
      debt: 0,
      hybrid: 0,
      alternate: 0,
      isAum: false,
    );
  }

  /// Create for AUM data
  factory InvestmentBreakdown.aum({
    required double equity,
    required double debt,
    required double hybrid,
    required double alternate,
  }) {
    return InvestmentBreakdown._(
      sip: 0,
      lumpsum: 0,
      switchAmount: 0,
      redemption: 0,
      swp: 0,
      stp: 0,
      equity: equity,
      debt: debt,
      hybrid: hybrid,
      alternate: alternate,
      isAum: true,
    );
  }

  double get totalTransaction =>
      sip + lumpsum + switchAmount + redemption + swp + stp;

  double get totalAum => equity + debt + hybrid + alternate;

  Map<String, double> getPercentageBreakdown() {
    if (isAum) {
      if (totalAum == 0) {
        return {
          'Equity': 0,
          'Debt': 0,
          'Hybrid': 0,
          'Alternate': 0,
        };
      }
      return {
        'Equity': equity / totalAum * 100,
        'Debt': debt / totalAum * 100,
        'Hybrid': hybrid / totalAum * 100,
        'Alternate': alternate / totalAum * 100,
      };
    } else {
      if (totalTransaction == 0) {
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
        'SIP': sip / totalTransaction * 100,
        'Lumpsum': lumpsum / totalTransaction * 100,
        'Switch': switchAmount / totalTransaction * 100,
        'Redemption': redemption / totalTransaction * 100,
        'SWP': swp / totalTransaction * 100,
        'STP': stp / totalTransaction * 100,
      };
    }
  }
}

class InvestmentChartWidget extends StatelessWidget {
  final InvestmentBreakdown data;

  const InvestmentChartWidget({
    super.key,
    required this.data,
  });

  // Transaction colors and labels
  static final List<List<Color>> _transactionGradients = [
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

  static final List<Color> _transactionColors = [
    AppColors.sipContainerColorCombination1,
    AppColors.lumpsumContainerColorCombination1,
    AppColors.switchContainerColorCombination1,
    AppColors.redeemContainerColorCombination1,
    AppColors.swpContainerColorCombination1,
    AppColors.stpContainerColorCombination1,
  ];

  static const List<String> _transactionLabels = [
    'SIP',
    'Lumpsum',
    'Switch',
    'Redemption',
    'SWP',
    'STP'
  ];

  // AUM colors and labels
  static final List<List<Color>> _aumGradients = [
    [
      AppColors.sipContainerColorCombination1,
      AppColors.sipContainerColorCombination2
    ], // Reuse or define AUM-specific colors
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
  ];

  static final List<Color> _aumColors = [
    AppColors.sipContainerColorCombination1,
    AppColors.lumpsumContainerColorCombination1,
    AppColors.switchContainerColorCombination1,
    AppColors.redeemContainerColorCombination1,
  ];

  static const List<String> _aumLabels = [
    'Equity',
    'Debt',
    'Hybrid',
    'Alternate',
  ];

  @override
  Widget build(BuildContext context) {
    final percentages = data.getPercentageBreakdown();
    final nonZeroEntries =
        percentages.entries.where((e) => e.value > 0).toList();

    final labels = data.isAum ? _aumLabels : _transactionLabels;
    final colors = data.isAum ? _aumColors : _transactionColors;
    final gradients = data.isAum ? _aumGradients : _transactionGradients;

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
                    final colorIndex = labels.indexOf(entry.key);
                    return PieChartSectionData(
                      value: entry.value,
                      title: '',
                      showTitle: false,
                      radius: chartSize * 0.3,
                      color: colors[colorIndex],
                      badgeWidget: _buildLabel(entry.key, entry.value,
                          colorIndex, index, nonZeroEntries.length, colors),
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
              children: nonZeroEntries.mapIndexed((index, entry) {
                final colorIndex = labels.indexOf(entry.key);
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
                          colors: gradients[colorIndex],
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
    String label,
    double percent,
    int colorIndex,
    int index,
    int total,
    List<Color> colors,
  ) {
    double verticalOffset = 0;
    if (index == 0) {
      verticalOffset = -12;
    } else if (index == total - 1 || index == total ~/ 2) {
      verticalOffset = 12;
    }

    Color labelColor = colors[colorIndex];

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
