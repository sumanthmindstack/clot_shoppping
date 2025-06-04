import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../../../../../themes/app_colors.dart';

//=========================//
//   InvestmentBreakdown   //
//=========================//
class InvestmentBreakdown {
  // Transaction fields
  final double sip, lumpsum, switchAmount, redemption, swp, stp;

  // AUM fields
  final double equity, debt, hybrid, alternate;

  // Growth fields
  final double growthA, growthB, growthC;

  final bool isAum, isTransaction, isGrowth;

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
    required this.growthA,
    required this.growthB,
    required this.growthC,
    required this.isAum,
    required this.isTransaction,
    required this.isGrowth,
  });

  /// Factory constructor for transaction data
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
      growthA: 0,
      growthB: 0,
      growthC: 0,
      isAum: false,
      isTransaction: true,
      isGrowth: false,
    );
  }

  /// Factory constructor for AUM data
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
      growthA: 0,
      growthB: 0,
      growthC: 0,
      isAum: true,
      isTransaction: false,
      isGrowth: false,
    );
  }

  /// Factory constructor for Growth data
  factory InvestmentBreakdown.growth({
    required double growthA,
    required double growthB,
    required double growthC,
  }) {
    return InvestmentBreakdown._(
      sip: 0,
      lumpsum: 0,
      switchAmount: 0,
      redemption: 0,
      swp: 0,
      stp: 0,
      equity: 0,
      debt: 0,
      hybrid: 0,
      alternate: 0,
      growthA: growthA,
      growthB: growthB,
      growthC: growthC,
      isAum: false,
      isTransaction: false,
      isGrowth: true,
    );
  }

  double get totalTransaction =>
      sip + lumpsum + switchAmount + redemption + swp + stp;
  double get totalAum => equity + debt + hybrid + alternate;
  double get totalGrowth => growthA + growthB + growthC;

  Map<String, double> getPercentageBreakdown() {
    if (isAum) {
      if (totalAum == 0)
        return {'Equity': 0, 'Debt': 0, 'Hybrid': 0, 'Alternate': 0};
      return {
        'Equity': equity / totalAum * 100,
        'Debt': debt / totalAum * 100,
        'Hybrid': hybrid / totalAum * 100,
        'Alternate': alternate / totalAum * 100,
      };
    } else if (isGrowth) {
      if (totalGrowth == 0) return {'Debt': 0, 'Hybrid': 0, 'Equity': 0};
      return {
        'Debt': growthA / totalGrowth * 100,
        'Hybrid': growthB / totalGrowth * 100,
        'Equity': growthC / totalGrowth * 100,
      };
    } else {
      if (totalTransaction == 0) {
        return {
          'SIP': 0,
          'Lumpsum': 0,
          'Switch': 0,
          'Redemption': 0,
          'SWP': 0,
          'STP': 0
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

//===========================//
//   InvestmentChartWidget   //
//===========================//
class InvestmentChartWidget extends StatelessWidget {
  final InvestmentBreakdown data;

  const InvestmentChartWidget({super.key, required this.data});

  // Transaction styling
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

  // AUM styling
  static final List<List<Color>> _aumGradients = [
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
    'Alternate'
  ];

  // Growth styling
  static final List<List<Color>> _growthGradients = [
    [const Color(0xFF759BEB), const Color(0xFF759BEB)],
    [Colors.red, Colors.red],
    [Colors.green, Colors.green.shade700],
  ];

  static final List<Color> _growthColors = [
    const Color(0xFF759BEB),
    Colors.red,
    Colors.green,
  ];

  static const List<String> _growthLabels = ['Debt', 'Hybrid', 'Equity'];

  @override
  Widget build(BuildContext context) {
    final percentages = data.getPercentageBreakdown();
    final nonZeroEntries =
        percentages.entries.where((e) => e.value > 0).toList();

    final labels = data.isAum
        ? _aumLabels
        : data.isGrowth
            ? _growthLabels
            : _transactionLabels;

    final colors = data.isAum
        ? _aumColors
        : data.isGrowth
            ? _growthColors
            : _transactionColors;

    final gradients = data.isAum
        ? _aumGradients
        : data.isGrowth
            ? _growthGradients
            : _transactionGradients;

    final chartSize = MediaQuery.of(context).size.width * 0.50;

    return Column(
      children: [
        SizedBox(
          height: chartSize,
          width: chartSize,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: chartSize * 0.18,
              sectionsSpace: 2,
              sections: nonZeroEntries.mapIndexed((index, entry) {
                final colorIndex = labels.indexOf(entry.key);
                return PieChartSectionData(
                  value: entry.value,
                  title: '',
                  showTitle: false,
                  radius: chartSize * 0.3,
                  color: colors[colorIndex],
                  badgeWidget: _buildLabel(
                    entry.key,
                    entry.value,
                    colorIndex,
                    index,
                    nonZeroEntries.length,
                    colors,
                  ),
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
                    gradient: LinearGradient(colors: gradients[colorIndex]),
                  ),
                ),
                Text(entry.key, style: const TextStyle(fontSize: 13)),
              ],
            );
          }).toList(),
        ),
      ],
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
    if (index == 0)
      verticalOffset = -12;
    else if (index == total - 1 || index == total ~/ 2) verticalOffset = 12;

    return Transform.translate(
      offset: Offset(0, verticalOffset),
      child: Text(
        '$label: ${percent.toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: colors[colorIndex],
        ),
      ),
    );
  }
}
