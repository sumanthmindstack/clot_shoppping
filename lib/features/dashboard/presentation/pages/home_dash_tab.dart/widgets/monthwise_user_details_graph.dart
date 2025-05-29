import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../themes/app_colors.dart';

class MonthwiseUserGraph extends StatefulWidget {
  final String title;
  final List<String> xLabels; // Numeric month strings "1", "2", ..., "12"
  final List<double> yValues; // Corresponding values for each month
  final String initialYear;
  final String subtitle;
  final ValueChanged<String> onYearChanged;
  final Color bar1Color;
  final Color bar2Color;

  const MonthwiseUserGraph({
    super.key,
    required this.title,
    required this.xLabels,
    required this.yValues,
    required this.initialYear,
    required this.onYearChanged,
    required this.subtitle,
    required this.bar1Color,
    required this.bar2Color,
  });

  @override
  State<MonthwiseUserGraph> createState() => _MonthwiseUserGraphState();
}

class _MonthwiseUserGraphState extends State<MonthwiseUserGraph> {
  late String selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialYear;
  }

  @override
  void didUpdateWidget(covariant MonthwiseUserGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialYear != oldWidget.initialYear) {
      setState(() {
        selectedYear = widget.initialYear;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.xLabels.length != widget.yValues.length) {
      throw ArgumentError('xLabels and yValues must have the same length');
    }

    final List<String> monthLabels = widget.xLabels.map((e) {
      final monthNum = int.tryParse(e);
      if (monthNum != null && monthNum >= 1 && monthNum <= 12) {
        return _monthNameFromNumber(monthNum);
      }
      return e;
    }).toList();

    final maxValue = widget.yValues.isEmpty ? 0 : widget.yValues.reduce(max);
    final maxY = _calculateNiceMaxY(maxValue.toDouble());
    final yInterval = _calculateNiceInterval(maxY);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.bar1Color, widget.bar2Color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 30,
                  width: 46,
                  child: DropdownButton<String>(
                    padding: EdgeInsets.all(0),
                    dropdownColor: Colors.white, // Dropdown background color
                    value: selectedYear,
                    items: List.generate(5, (index) {
                      final year = (DateTime.now().year - index).toString();
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year,
                            style: const TextStyle(color: Colors.black)),
                      );
                    }),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          selectedYear = value;
                        });
                        widget.onYearChanged(value);
                      }
                    },
                    iconSize: 14,
                    iconEnabledColor: Colors.black, // icon color
                    style: const TextStyle(color: Colors.black),
                    underline: SizedBox(), // Remove the default underline
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Bar Chart
        AspectRatio(
          aspectRatio: 1.7,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY > 0 ? maxY : 10,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.blueGrey,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final month = monthLabels[group.x.toInt()];
                    final value = rod.toY.toInt();
                    return BarTooltipItem(
                      '$month: $value',
                      const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  axisNameWidget: Text(
                    widget.subtitle,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryGrey),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: yInterval,
                    getTitlesWidget: (value, _) => Text(
                      value.toInt().toString(),
                      style:
                          const TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                    reservedSize: 30,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      final index = value.toInt();
                      if (index >= 0 && index < monthLabels.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            monthLabels[index],
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: yInterval,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                  left:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                  right: const BorderSide(color: Colors.transparent),
                  top: const BorderSide(color: Colors.transparent),
                ),
              ),
              barGroups: List.generate(
                monthLabels.length,
                (index) => BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: widget.yValues[index],
                      width: 16,
                      gradient: LinearGradient(
                        colors: [widget.bar1Color, widget.bar2Color],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY > 0 ? maxY : 10,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
                    colors: [widget.bar1Color, widget.bar2Color],
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

  String _monthNameFromNumber(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return month >= 1 && month <= 12 ? monthNames[month - 1] : '';
  }

  double _calculateNiceMaxY(double maxValue) {
    if (maxValue <= 0) return 10;
    double exponent = (log(maxValue) / ln10).floorToDouble();
    double fraction = maxValue / pow(10, exponent);
    double niceFraction;
    if (fraction <= 1)
      niceFraction = 1;
    else if (fraction <= 2)
      niceFraction = 2;
    else if (fraction <= 5)
      niceFraction = 5;
    else
      niceFraction = 10;
    return niceFraction * pow(10, exponent);
  }

  double _calculateNiceInterval(double maxY) {
    if (maxY <= 0) return 2;
    double roughInterval = maxY / 5;
    double exponent = (log(roughInterval) / ln10).floorToDouble();
    double fraction = roughInterval / pow(10, exponent);
    double niceFraction;
    if (fraction <= 1)
      niceFraction = 1;
    else if (fraction <= 2)
      niceFraction = 2;
    else if (fraction <= 5)
      niceFraction = 5;
    else
      niceFraction = 10;
    return niceFraction * pow(10, exponent);
  }
}
