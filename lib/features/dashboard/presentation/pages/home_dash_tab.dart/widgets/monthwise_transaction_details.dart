import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class MonthwiseTransactionGraph extends StatelessWidget {
  final String title;
  final List<String> xLabels;
  final List<String> yLabels;
  final String initialYear;
  final ValueChanged<String> onYearChanged;
  final String subtitle;
  final Color bar1Color;
  final Color bar2Color;

  const MonthwiseTransactionGraph({
    super.key,
    required this.title,
    required this.xLabels,
    required this.yLabels,
    required this.initialYear,
    required this.onYearChanged,
    required this.subtitle,
    required this.bar1Color,
    required this.bar2Color,
  });

  String formatAmount(double amount) {
    if (amount >= 10000000) {
      return "${(amount / 10000000).toStringAsFixed(1)}Cr";
    } else if (amount >= 100000) {
      return "${(amount / 100000).toStringAsFixed(1)}L";
    } else if (amount >= 1000) {
      return "${(amount / 1000).toStringAsFixed(1)}K";
    } else {
      return amount.toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final parsedYValues =
        yLabels.map((e) => double.tryParse(e) ?? 0.0).toList();
    final yValues = List<double>.filled(12, 0.0);
    for (int i = 0; i < xLabels.length; i++) {
      final monthIndex = _getMonthIndex(xLabels[i]);
      if (monthIndex != -1 && i < parsedYValues.length) {
        yValues[monthIndex] = parsedYValues[i];
      }
    }

    final maxY =
        (yValues.isEmpty ? 0 : yValues.reduce((a, b) => a > b ? a : b)) * 1.2;

    final defaultMonths = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [bar1Color, bar2Color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.pureWhite,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 30,
                  width: 46,
                  child: DropdownButton<String>(
                    value: initialYear,
                    dropdownColor: Colors.white,
                    underline: const SizedBox(),
                    iconEnabledColor: Colors.black,
                    iconSize: 14,
                    style: const TextStyle(color: Colors.black),
                    items: List.generate(5, (index) {
                      final year = (DateTime.now().year - index).toString();
                      return DropdownMenuItem(value: year, child: Text(year));
                    }),
                    onChanged: (String? value) {
                      if (value != null) {
                        onYearChanged(value);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.7,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY > 0 ? maxY : 100,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade800
                          : Colors.white,
                  tooltipPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final month = defaultMonths[group.x.toInt()];
                    final value = rod.toY.toInt();
                    final textColor =
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black;

                    return BarTooltipItem(
                      '$month\nTotal Amount:₹$value',
                      TextStyle(color: textColor, fontSize: 12),
                      textAlign: TextAlign.left,
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  axisNameWidget: Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryGrey,
                    ),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: maxY > 0 ? maxY / 5 : 20,
                    getTitlesWidget: (value, _) => Text(
                      formatAmount(value),
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.black20,
                      ),
                    ),
                    reservedSize: 40,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, _) {
                      final index = value.toInt();
                      if (index >= 0 && index < defaultMonths.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            defaultMonths[index],
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.black20,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: maxY > 0 ? maxY / 5 : 20,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1,
                  ),
                  left: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1,
                  ),
                  right: BorderSide.none,
                  top: BorderSide.none,
                ),
              ),
              barGroups: List.generate(
                12,
                (index) => BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: yValues[index],
                      width: 16,
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        colors: [bar1Color, bar2Color],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY > 0 ? maxY : 100,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [bar1Color, bar2Color],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.black20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int _getMonthIndex(String month) {
    switch (month.toLowerCase()) {
      case "january":
      case "jan":
        return 0;
      case "february":
      case "feb":
        return 1;
      case "march":
      case "mar":
        return 2;
      case "april":
      case "apr":
        return 3;
      case "may":
        return 4;
      case "june":
      case "jun":
        return 5;
      case "july":
      case "jul":
        return 6;
      case "august":
      case "aug":
        return 7;
      case "september":
      case "sep":
      case "sept":
        return 8;
      case "october":
      case "oct":
        return 9;
      case "november":
      case "nov":
        return 10;
      case "december":
      case "dec":
        return 11;
      default:
        return -1;
    }
  }
}
