import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class InvestorCardShimmer extends StatelessWidget {
  const InvestorCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 8,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Container(
          decoration: _cardBoxDecoration,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _buildHeaderShimmer(),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  _buildFooterShimmer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderShimmer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(width: 120, height: 16),
              const SizedBox(height: 6),
              _shimmerBox(width: 180, height: 14),
              const SizedBox(height: 6),
              _shimmerBox(width: 140, height: 14),
            ],
          ),
        ),
        _shimmerBox(width: 60, height: 20),
      ],
    );
  }

  Widget _buildFooterShimmer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _shimmerIconText(),
            _shimmerIconText(),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _shimmerIconText(),
            _shimmerBox(width: 60, height: 20),
          ],
        ),
      ],
    );
  }

  Widget _shimmerIconText() {
    return Row(
      children: [
        const Icon(Icons.circle, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        _shimmerBox(width: 80, height: 12),
      ],
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  BoxDecoration get _cardBoxDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      );
}
