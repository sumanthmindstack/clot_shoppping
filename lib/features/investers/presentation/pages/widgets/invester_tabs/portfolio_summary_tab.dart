import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/core/utils/duration_converter.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/pages/widgets/invester_tabs/widgets/portfolio_summary_chart.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../../../../../dashboard/presentation/pages/home_dash_tab.dart/widgets/trans_result_donut_chart.dart';
import '../../../bloc/portfolio_analysis/portfolio_analysis_cubit.dart';
import '../../../bloc/portfolio_analysis_graph_data/portfolio_analysis_graph_data_cubit.dart';
import 'widget_shimmers/load_company_weight_chart.dart';
import 'widgets/company_weight_chart.dart';

class PortfolioSummaryTab extends StatefulWidget {
  final int userId;
  const PortfolioSummaryTab({super.key, required this.userId});

  @override
  State<PortfolioSummaryTab> createState() => _PortfolioSummaryTabState();
}

class _PortfolioSummaryTabState extends State<PortfolioSummaryTab> {
  @override
  void initState() {
    super.initState();
    context
        .read<PortfolioAnalysisGraphDataCubit>()
        .getPortfolioAnalysisGraphData(userId: widget.userId, duration: 365);
    context
        .read<PortfolioAnalysisCubit>()
        .getPortfolioAnalysis(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _portfolioSummary(context),
        const SizedBox(height: 50),
        _assetAllocationText(context),
        const SizedBox(height: 10),
        _portfolioGraphData(context),
        const SizedBox(height: 10),
        _companyWeightsChartData(context),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _portfolioSummary(BuildContext context) {
    return BlocConsumer<PortfolioAnalysisGraphDataCubit,
        PortfolioAnalysisGraphDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PortfolioAnalysisGraphDataLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }
        if (state is PortfolioAnalysisGraphDataSuccessState) {
          return PortfolioSummaryChart(
            onRangeSelected: (value) {
              final duration = DurationConverter.convertToDays(value);
              context
                  .read<PortfolioAnalysisGraphDataCubit>()
                  .getPortfolioAnalysisGraphData(
                      userId: widget.userId, duration: duration);
            },
            data: state.entity.data,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _assetAllocationText(BuildContext context) {
    return const Text(
      "Asset Allocation",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _portfolioGraphData(BuildContext context) {
    return BlocConsumer<PortfolioAnalysisCubit, PortfolioAnalysisState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PortfolioAnalysisLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }
        if (state is PortfolioAnalysisFailureState) {
          return const Center(
            child: Text("No Data Available"),
          );
        }
        if (state is PortfolioAnalysisSuccessState) {
          final data = state.entity.data.categoryBaseAllocation;
          final entries = data.entries.toList();

          double safeGetValue(List<MapEntry> entries, int index) =>
              entries.length > index ? entries[index].value : 0;

          return Center(
            child: InvestmentChartWidget(
              data: InvestmentBreakdown.growth(
                growthA: safeGetValue(entries, 0),
                growthB: safeGetValue(entries, 1),
                growthC: safeGetValue(entries, 2),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _companyWeightsChartData(BuildContext context) {
    return BlocConsumer<PortfolioAnalysisCubit, PortfolioAnalysisState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PortfolioAnalysisLoadingState) {
          return const LoadCompanyWeightChartShimmer();
        }
        if (state is PortfolioAnalysisSuccessState) {
          final Map<String, dynamic> stockBaseAllocationMap =
              state.entity.data.stockBaseAllocation;

          final Map<String, double> companyWeights = stockBaseAllocationMap.map(
            (key, value) => MapEntry(key, value.toDouble()),
          );
          final Map<String, dynamic> topSectors =
              state.entity.data.sectorBaseAllocation;

          final Map<String, double> topSectorDatas = topSectors.map(
            (key, value) => MapEntry(key, value.toDouble()),
          );
          return Column(
            children: [
              const SizedBox(height: 20),
              CompanyWeightChart(
                companyWeights: companyWeights,
                title: "Top Equity Holding",
              ),
              const SizedBox(height: 10),
              CompanyWeightChart(
                companyWeights: topSectorDatas,
                title: "Top 10 Sector Exposure",
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
