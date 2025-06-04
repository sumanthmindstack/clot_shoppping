import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../../../../../domain/entity/portfolio_analysis_graph_data_entity.dart';

class PortfolioSummaryChart extends StatefulWidget {
  final List<PortfolioAnalysisGraphDataItemEntity> data;
  final ValueChanged<String>? onRangeSelected;
  const PortfolioSummaryChart(
      {super.key, required this.data, this.onRangeSelected});

  @override
  State<PortfolioSummaryChart> createState() => _PortfolioSummaryChartState();
}

class _PortfolioSummaryChartState extends State<PortfolioSummaryChart> {
  bool showInvested = true;
  bool showCurrent = true;

  final List<String> _ranges = ['1M', '3M', '6M', '1Y', '5Y'];
  String _selectedRange = '1Y';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black54;
    final gridColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    final borderColor = isDarkMode ? Colors.grey.shade700 : Colors.black12;

    final filteredData = _filterDataByRange(widget.data, _selectedRange);

    final spotsInvested = <FlSpot>[];
    final spotsCurrent = <FlSpot>[];
    final dateLabels = <int, String>{};

    for (int i = 0; i < filteredData.length; i++) {
      spotsInvested.add(FlSpot(i.toDouble(), filteredData[i].investedAmount));
      spotsCurrent.add(FlSpot(i.toDouble(), filteredData[i].currentValue));
      DateTime dateValue;
      if (filteredData[i].date is DateTime) {
        dateValue = filteredData[i].date as DateTime;
      } else if (filteredData[i].date is String) {
        dateValue =
            DateTime.tryParse(filteredData[i].date as String) ?? DateTime.now();
      } else {
        dateValue = DateTime.now();
      }
      dateLabels[i] = DateFormat('MMM yy').format(dateValue);
    }

    final maxYValue = _calculateMaxY(spotsInvested, spotsCurrent);
    final yInterval = _calculateYInterval(maxYValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Portfolio Summary",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Container(
          height: 250,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: LineChart(
            LineChartData(
              backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
              minY: 0,
              maxY: maxYValue * 1.1,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: yInterval,
                verticalInterval:
                    filteredData.length > 10 ? (filteredData.length / 5) : 1,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: gridColor,
                  strokeWidth: 0.5,
                ),
                getDrawingVerticalLine: (value) => FlLine(
                  color: gridColor.withOpacity(0.3),
                  strokeWidth: 0.3,
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 24,
                    interval: filteredData.length > 10
                        ? (filteredData.length / 5)
                        : 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < filteredData.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            dateLabels[index] ?? '',
                            style: TextStyle(fontSize: 10, color: textColor),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 42,
                    interval: yInterval,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          _formatAmount(value),
                          style: TextStyle(fontSize: 10, color: textColor),
                        ),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              lineBarsData: [
                if (showInvested)
                  LineChartBarData(
                    spots: spotsInvested,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: const Color(0xFF9381FF),
                    barWidth: 2.5,
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF9381FF).withOpacity(0.1),
                    ),
                    dotData: FlDotData(
                      show: filteredData.length <= 10,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                        radius: 3,
                        color: const Color(0xFF9381FF),
                        strokeWidth: 1,
                        strokeColor: Colors.white,
                      ),
                    ),
                  ),
                if (showCurrent)
                  LineChartBarData(
                    spots: spotsCurrent,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: const Color(0xFF75C596),
                    barWidth: 2.5,
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF75C596).withOpacity(0.1),
                    ),
                    dotData: FlDotData(
                      show: filteredData.length <= 10,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                        radius: 3,
                        color: const Color(0xFF75C596),
                        strokeWidth: 1,
                        strokeColor: Colors.white,
                      ),
                    ),
                  ),
              ],
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(color: borderColor),
                  bottom: BorderSide(color: borderColor),
                ),
              ),
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor:
                      isDarkMode ? Colors.grey.shade800 : Colors.white,
                  tooltipPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final label = spot.barIndex == 0 ? 'Invested' : 'Current';
                      return LineTooltipItem(
                        '$label ${_formatAmountFull(spot.y)}',
                        TextStyle(color: textColor, fontSize: 12),
                        textAlign: TextAlign.center,
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showInvested)
              _buildLegendItem(
                color: const Color(0xFF9381FF),
                label: 'Invested',
                textColor: textColor,
              ),
            if (showInvested && showCurrent) const SizedBox(width: 16),
            if (showCurrent)
              _buildLegendItem(
                color: const Color(0xFF75C596),
                label: 'Current',
                textColor: textColor,
              ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _ranges.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final range = _ranges[index];
                final isSelected = _selectedRange == range;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRange = range;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.pureWhite : Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        range,
                        style: TextStyle(
                          color: isSelected ? Colors.white : textColor,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<PortfolioAnalysisGraphDataItemEntity> _filterDataByRange(
      List<PortfolioAnalysisGraphDataItemEntity> allData, String range) {
    final now = DateTime.now();
    DateTime cutoff;

    switch (range) {
      case '1M':
        cutoff = DateTime(now.year, now.month - 1, now.day);
        break;
      case '3M':
        cutoff = DateTime(now.year, now.month - 3, now.day);
        break;
      case '6M':
        cutoff = DateTime(now.year, now.month - 6, now.day);
        break;
      case '1Y':
        cutoff = DateTime(now.year - 1, now.month, now.day);
        break;
      case '5Y':
        cutoff = DateTime(now.year - 5, now.month, now.day);
        break;
      default:
        cutoff = DateTime(2000);
    }

    return allData.where((item) {
      DateTime dateValue;
      if (item.date is DateTime) {
        dateValue = item.date as DateTime;
      } else if (item.date is String) {
        dateValue = DateTime.tryParse(item.date as String) ?? DateTime(2000);
      } else {
        dateValue = DateTime(2000);
      }
      return dateValue.isAfter(cutoff);
    }).toList();
  }

  Widget _buildLegendItem(
      {required Color color, required String label, required Color textColor}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: textColor)),
      ],
    );
  }

  String _formatAmount(double value) {
    if (value >= 10000000) return '₹${(value / 10000000).toStringAsFixed(1)}Cr';
    if (value >= 100000) return '₹${(value / 100000).toStringAsFixed(1)}L';
    if (value >= 1000) return '₹${(value / 1000).toStringAsFixed(0)}K';
    return '₹${value.toStringAsFixed(0)}';
  }

  String _formatAmountFull(double value) {
    final formatter =
        NumberFormat.currency(symbol: '₹', decimalDigits: value < 100 ? 2 : 0);
    return formatter.format(value);
  }

  double _calculateMaxY(List<FlSpot> spots1, List<FlSpot> spots2) {
    final max1 =
        spots1.isNotEmpty ? spots1.map((e) => e.y).reduce(math.max) : 0;
    final max2 =
        spots2.isNotEmpty ? spots2.map((e) => e.y).reduce(math.max) : 0;
    return math.max(max1, max2).toDouble();
  }

  double _calculateYInterval(double maxY) {
    if (maxY <= 0) return 10;
    final interval = (maxY / 5).ceilToDouble();
    return interval > 0 ? interval : 10;
  }
}
