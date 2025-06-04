import 'package:flutter/material.dart';

class LoadCompanyWeightChartShimmer extends StatelessWidget {
  const LoadCompanyWeightChartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _shimmerCard(),
        const SizedBox(height: 12),
        _shimmerCard(),
      ],
    );
  }

  Widget _shimmerCard() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _shimmerBox(width: 100, height: 18),
              const Spacer(),
              _shimmerBox(width: 24, height: 24),
            ],
          ),
          const SizedBox(height: 10),
          _shimmerRow(),
        ],
      ),
    );
  }

  Widget _shimmerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 4, child: _shimmerBox(height: 14)),
          const SizedBox(width: 10),
          Expanded(flex: 6, child: _shimmerBox(height: 8)),
          const SizedBox(width: 10),
          _shimmerBox(width: 40, height: 14),
        ],
      ),
    );
  }

  Widget _shimmerBox({double width = double.infinity, double height = 16}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
