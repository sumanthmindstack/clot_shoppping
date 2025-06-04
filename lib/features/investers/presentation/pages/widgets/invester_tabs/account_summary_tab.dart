import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../../../../domain/entity/account_summary_data_entity.dart';
import '../../../bloc/account_summary_data/account_summary_data_cubit.dart';

class AccountSummaryTab extends StatefulWidget {
  final int userId;
  const AccountSummaryTab({super.key, required this.userId});

  @override
  State<AccountSummaryTab> createState() => _AccountSummaryTabState();
}

class _AccountSummaryTabState extends State<AccountSummaryTab> {
  String _selectedScale = 'Actual';
  @override
  void initState() {
    initCallApis(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountSummaryDataCubit, AccountSummaryDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AccountSummaryDataLoadingState) {
          return const Center(
            heightFactor: 10,
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }
        if (state is AccountSummaryDataSuccessState) {
          final data = state.accountSummaryDataEntity.data![0];
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildScaleSelector(),
                const SizedBox(height: 10),
                _buildPerformanceDetails(context, data),
              ],
            ),
          );
        }
        return const Center(
          heightFactor: 10,
          child: Text("No Data Available"),
        );
      },
    );
  }

  Widget _buildScaleSelector() {
    final scales = ['Actual', 'Thousands', 'Lakhs', 'Crores', 'Billion'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: scales.map((scale) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                scale,
                style: TextStyle(
                  color: _selectedScale == scale
                      ? Colors.white
                      : AppColors.primaryColor,
                ),
              ),
              selected: _selectedScale == scale,
              onSelected: (selected) {
                setState(() {
                  _selectedScale = selected ? scale : 'Actual';
                });
              },
              selectedColor: AppColors.primaryColor,
              backgroundColor: AppColors.pureWhite,
              checkmarkColor: Colors.white,
              shape: StadiumBorder(
                side: BorderSide(
                  color: _selectedScale == scale
                      ? Colors.transparent
                      : AppColors.primaryColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPerformanceDetails(
      BuildContext context, InvestmentAccountEntity data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _buildMetricRow(
                  context, 'Invested Amount', '₹ ${data.investedAmount}'),
              const Divider(),
              _buildMetricRow(
                  context, 'Current Value', '₹  ${data.currentValue}'),
              const Divider(),
              _buildMetricRow(
                  context, 'Unrealised Gain', '₹  ${data.unrealizedGain}'),
              const Divider(),
              _buildMetricRow(
                  context, 'Absolute Returns', ' ${data.absoluteReturn}%'),
              const Divider(),
              _buildMetricRow(context, 'CAGR', '1.13%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricRow(BuildContext context, String label, String value) {
    final isPositive = value.startsWith('+') ||
        (value.contains('%') && !value.startsWith('-') && value != '0.00%');
    final isPercentage = value.contains('%');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[800],
                ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isPercentage
                  ? (isPositive ? AppColors.primaryColor : Colors.red[600])
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  void initCallApis(BuildContext context) {
    context
        .read<AccountSummaryDataCubit>()
        .getAccountSummaryData(page: 1, userId: widget.userId, limit: 10);
  }
}
