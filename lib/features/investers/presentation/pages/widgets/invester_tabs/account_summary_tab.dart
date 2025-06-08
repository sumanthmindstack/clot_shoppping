import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/formatters.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../../../../../../widgets/units_selection_widget.dart';
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
        if (state is AccountSummaryDataFailureState) {
          return const Center(
            heightFactor: 10,
            child: Text("No Data Available"),
          );
        }
        if (state is AccountSummaryDataSuccessState) {
          final data = state.accountSummaryDataEntity.data;
          return data!.isEmpty
              ? const Center(
                  heightFactor: 10,
                  child: Text("No Data Available"),
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildScaleSelector(),
                      const SizedBox(height: 10),
                      _buildPerformanceDetails(context, data[0]),
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

    return UnitsSelectionWidget(
        selectedScale: _selectedScale,
        onScaleSelected: (value) {
          setState(() {
            _selectedScale = value;
          });
        },
        scales: scales);
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
                  context, 'Invested Amount', '${data.investedAmount}'),
              const Divider(),
              _buildMetricRow(context, 'Current Value', data.currentValue),
              const Divider(),
              _buildMetricRow(context, 'Unrealised Gain', data.unrealizedGain),
              const Divider(),
              _buildMetricRow(
                  context, 'Absolute Returns', '${data.absoluteReturn}%'),
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
            Formatters()
                .formatWithUnit(_safeParse(value).toInt(), _selectedScale),
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

  double _safeParse(String value) {
    return double.tryParse(value.replaceAll(RegExp(r'[^\d\.-]'), '')) ?? 0.0;
  }

  void initCallApis(BuildContext context) {
    context
        .read<AccountSummaryDataCubit>()
        .getAccountSummaryData(page: 1, userId: widget.userId, limit: 10);
  }
}
