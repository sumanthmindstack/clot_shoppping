import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HoldingsCardShimmer extends StatelessWidget {
  const HoldingsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderShimmer(),
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade200, height: 1),
                  const SizedBox(height: 12),
                  _buildDetailsRowShimmer(),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 10,
                      width: 80,
                      color: Colors.grey,
                    ),
                  ),
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
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 14, width: double.infinity, color: Colors.grey),
              const SizedBox(height: 8),
              Container(height: 12, width: 100, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsRowShimmer() {
    return const Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ShimmerLabelBox(),
              SizedBox(height: 8),
              _ShimmerLabelBox(),
              SizedBox(height: 8),
              _ShimmerLabelBox(),
              SizedBox(height: 8),
              _ShimmerLabelBox(),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _ShimmerValueBox(),
              SizedBox(height: 8),
              _ShimmerValueBox(),
              SizedBox(height: 8),
              _ShimmerValueBox(),
              SizedBox(height: 8),
              _ShimmerValueBox(),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShimmerLabelBox extends StatelessWidget {
  const _ShimmerLabelBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 80,
      color: Colors.grey,
    );
  }
}

class _ShimmerValueBox extends StatelessWidget {
  const _ShimmerValueBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 60,
      color: Colors.grey,
    );
  }
}
