import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxwealth_distributor_app/common/formatters.dart';
import 'package:maxwealth_distributor_app/features/dashboard/presentation/pages/home_dash_tab.dart/widgets/profile_widget.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../../../../../gen/assets.gen.dart';
import '../../bloc/dash_aum_report_graph/dash_aum_report_graph_cubit.dart';
import '../../bloc/dash_monthwise_invester_details_graph/dash_monthwise_invester_details_graph_cubit.dart';
import '../../bloc/dash_monthwise_sip_details_graph/dash_monthwise_sip_details_graph_cubit.dart';
import '../../bloc/dash_monthwise_trans_details_graph/dash_monthwise_trans_details_graph_cubit.dart';
import '../../bloc/dash_monthwise_user_details_graph/dash_monthwise_user_details_graph_cubit.dart';
import '../../bloc/dashboard_data_count/dashboard_data_count_cubit.dart';
import '../../bloc/selected_type/selected_type_cubit.dart';
import '../../bloc/trans_typewise_returns/trans_typewise_returns_cubit.dart';
import 'widgets/monthwise_transaction_details.dart';
import 'widgets/monthwise_user_details_graph.dart';
import 'widgets/trans_result_donut_chart.dart';

class HomeDashTabScreen extends StatefulWidget {
  const HomeDashTabScreen({super.key});

  @override
  _HomeDashTabScreenState createState() => _HomeDashTabScreenState();
}

class _HomeDashTabScreenState extends State<HomeDashTabScreen> {
  List<String> _userMonths = [];
  List<double> _userValues = [];
  List<String> _transMonths = [];
  List<double> _transValues = [];

  int _selectedUserYear = DateTime.now().year;
  int _selectedInvesterYear = DateTime.now().year;
  int _selectedAumYear = DateTime.now().year;
  int _selectedTransYear = DateTime.now().year;
  int _selectedSipYear = DateTime.now().year;

  @override
  void initState() {
    intialApiCalls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ProfileWidget(),
          const SizedBox(height: 20),
          _buildDashboardCounts(),
          const SizedBox(height: 30),
          _userOrInvesterGraph(),
          const SizedBox(height: 30),
          _buildTransactionDetailsGraph(),
          const SizedBox(height: 30),
          _buildTransactionBreakdownSection(),
          const SizedBox(height: 30),
          _buildSipDetailsGraph(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildDashboardCounts() {
    return BlocBuilder<DashboardDataCountCubit, DashboardDataCountState>(
      builder: (context, state) {
        var totalUsers = "0";
        var totalInvestors = "0";
        var totalAum = "0";

        if (state is DashboardDataCountSuccessState) {
          final data = state.dashboardDatacountEntity.data;
          totalUsers = "${data.totalUsers}";
          totalInvestors = "${data.totalInvestors}";
          totalAum = "434327";
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoCard(
              icon: Assets.images.userImage.path,
              title: 'User',
              value: totalUsers,
              color: [AppColors.dodgerBlue, AppColors.deepSkyBlue],
            ),
            const SizedBox(width: 8),
            _buildInfoCard(
              icon: Assets.images.investerImage.path,
              title: 'Investor',
              value: totalInvestors,
              color: [AppColors.tropicalTeal, AppColors.oceanMist],
            ),
            const SizedBox(width: 8),
            _buildInfoCard(
              icon: Assets.images.totalAumImage.path,
              title: 'Total AUM',
              value: totalAum,
              color: [AppColors.sunsetGold, AppColors.coralBlush],
            ),
          ],
        );
      },
    );
  }

  Widget _userOrInvesterGraph() {
    return BlocConsumer<SelectedTypeCubit, String>(
      listener: (context, state) {
        if (state.contains("User")) {
          context
              .read<DashMonthwiseUserDetailsGraphCubit>()
              .fetchMonthwiseUserDetailsGraph(
                filter: "yearly",
                year: _selectedUserYear,
              );
        } else if (state.contains("Investor")) {
          context
              .read<DashMonthwiseInvesterDetailsGraphCubit>()
              .fetchMonthwiseInvesterDetailsGraph(
                filter: "yearly",
                year: _selectedInvesterYear,
              );
        } else if (state.contains("Total AUM")) {
          // context
          //     .read<DashAumReportGraphCubit>()
          //     .fetchAumReportGraph(year: _selectedAumYear);
        }
      },
      builder: (context, state) {
        if (state.contains("User")) {
          return _buildUserDetailsGraph();
        } else if (state.contains("Investor")) {
          return _buildInvesterDetailsGraph();
        } else if (state.contains("Total AUM")) {
          return _buildAumDetailsGraph();
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildUserDetailsGraph() {
    return BlocBuilder<DashMonthwiseUserDetailsGraphCubit,
        DashMonthwiseUserDetailsGraphState>(
      builder: (context, state) {
        if (state is DashMonthwiseUserDetailsGraphSuccessState) {
          _userMonths = state.graphData.monthsData
              .map((e) => e.month.toString())
              .toList();
          _userValues = state.graphData.monthsData
              .map((e) => e.totalInvestors.toDouble())
              .toList();
        }

        return MonthwiseUserGraph(
          bar1Color: const Color(0xFF1E90FF),
          bar2Color: const Color(0xFF00BFFF),
          title: 'Monthwise User Details',
          subtitle: 'Count',
          xLabels: _userMonths,
          yValues: _userValues,
          initialYear: _selectedUserYear.toString(),
          onYearChanged: (newYearStr) {
            final newYear = int.tryParse(newYearStr);
            if (newYear != null) {
              context
                  .read<DashMonthwiseUserDetailsGraphCubit>()
                  .fetchMonthwiseUserDetailsGraph(
                    filter: "yearly",
                    year: newYear,
                  );
              setState(() {
                _selectedUserYear = newYear;
              });
            }
          },
        );
      },
    );
  }

  Widget _buildInvesterDetailsGraph() {
    return BlocBuilder<DashMonthwiseInvesterDetailsGraphCubit,
        DashMonthwiseInvesterDetailsGraphState>(
      builder: (context, state) {
        if (state is DashMonthwiseInvesterDetailsGraphSuccessState) {
          _userMonths = state.graphData.monthsData
              .map((e) => e.month.toString())
              .toList();
          _userValues = state.graphData.monthsData
              .map((e) => e.totalInvestors.toDouble())
              .toList();
        }

        return MonthwiseUserGraph(
          bar1Color: AppColors.tropicalTeal,
          bar2Color: AppColors.oceanMist,
          title: 'Monthwise Invester Details',
          subtitle: 'Count',
          xLabels: _userMonths,
          yValues: _userValues,
          initialYear: _selectedInvesterYear.toString(),
          onYearChanged: (newYearStr) {
            final newYear = int.tryParse(newYearStr);
            if (newYear != null) {
              context
                  .read<DashMonthwiseInvesterDetailsGraphCubit>()
                  .fetchMonthwiseInvesterDetailsGraph(
                    filter: "yearly",
                    year: newYear,
                  );
              setState(() {
                _selectedInvesterYear = newYear;
              });
            }
          },
        );
      },
    );
  }

  Widget _buildAumDetailsGraph() {
    return BlocBuilder<DashAumReportGraphCubit, DashAumReportGraphState>(
      builder: (context, state) {
        if (state is DashAumReportGraphSuccessState) {
          _userMonths = state.graphData.monthlyData
              .map((e) => e.month.toString())
              .toList();

          _userValues = state.graphData.monthlyData
              .map((e) => (e.equity + e.debt + e.hybrid + e.alternate))
              .toList();
        }

        return Column(
          children: [
            aumReportSection(),
            const SizedBox(
              height: 10,
            ),
            MonthwiseTransactionGraph(
              bar1Color: AppColors.sunsetGold,
              bar2Color: AppColors.coralBlush,
              title: 'Monthwise AUM Details',
              subtitle: 'Count',
              xLabels: _userMonths,
              yLabels: _userValues.map((e) => e.toString()).toList(),
              initialYear: _selectedAumYear.toString(),
              onYearChanged: (newYearStr) {
                final newYear = int.tryParse(newYearStr);
                if (newYear != null) {
                  context.read<DashAumReportGraphCubit>().fetchAumReportGraph(
                        year: newYear,
                      );
                  setState(() {
                    _selectedAumYear = newYear;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTransactionDetailsGraph() {
    return BlocBuilder<DashMonthwiseTransDetailsGraphCubit,
        DashMonthwiseTransDetailsGraphState>(
      builder: (context, state) {
        List<String> months = [];
        List<double> values = [];

        if (state is DashMonthwiseTransDetailsGraphSuccessState) {
          months = state.graphData.result.map((e) => e.month).toList();
          values = state.graphData.result
              .map((e) => double.tryParse(e.totalAmount.toString()) ?? 0)
              .toList();
        }

        return MonthwiseTransactionGraph(
          bar1Color: AppColors.primaryBlue,
          bar2Color: AppColors.secondaryBlue,
          title: 'Monthwise Transaction Details',
          subtitle: 'Amount',
          xLabels: months,
          yLabels: values.map((e) => e.toString()).toList(),
          initialYear: _selectedTransYear.toString(),
          onYearChanged: (newYearStr) {
            final newYear = int.tryParse(newYearStr);
            if (newYear != null) {
              context
                  .read<DashMonthwiseTransDetailsGraphCubit>()
                  .fetchMonthwiseTransDetailsGraph(year: newYear);
              setState(() {
                _selectedTransYear = newYear;
              });
            }
          },
        );
      },
    );
  }

  Widget _buildSipDetailsGraph() {
    return BlocBuilder<DashMonthwiseSipDetailsGraphCubit,
        DashMonthwiseSipDetailsGraphState>(
      builder: (context, state) {
        List<String> months = [];
        List<double> values = [];

        if (state is DashMonthwiseSipDetailsGraphSuccessState) {
          months = state.dashMonthwiseSipDetailsGraphEntity.data
              .map((e) => e.month)
              .toList();
          values = state.dashMonthwiseSipDetailsGraphEntity.data
              .map((e) => double.tryParse(e.totalSipAmount.toString()) ?? 0)
              .toList();
        }

        return MonthwiseTransactionGraph(
          bar1Color: const Color(0xFF43C6AC),
          bar2Color: const Color(0xFF191654).withOpacity(0.7),
          title: 'Monthwise SIP Details',
          subtitle: 'Amount',
          xLabels: months,
          yLabels: values.map((e) => e.toString()).toList(),
          initialYear: _selectedSipYear.toString(),
          onYearChanged: (newYearStr) {
            final newYear = int.tryParse(newYearStr);
            if (newYear != null) {
              context
                  .read<DashMonthwiseSipDetailsGraphCubit>()
                  .fetchDashMonthwiseSipDetailsGraph(year: newYear);
              setState(() {
                _selectedSipYear = newYear;
              });
            }
          },
        );
      },
    );
  }

  Widget _buildTransactionBreakdownSection() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.lightBlue.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: const Row(
            children: [
              Text(
                'Transaction Breakdown',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<TransTypewiseReturnsCubit,
                TransTypewiseReturnsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is TransTypewiseReturnsSuccessState) {
                  final breakdownValues = state.breakdownValues;

                  return Column(
                    children: [
                      _buildBreakdownRow(
                          containerItems: breakdownValues.sublist(0, 2),
                          containerGradients: [
                            [
                              AppColors.sipContainerColorCombination1,
                              AppColors.sipContainerColorCombination2
                                  .withOpacity(0.7)
                            ],
                            [
                              AppColors.lumpsumContainerColorCombination1,
                              AppColors.lumpsumContainerColorCombination2
                                  .withOpacity(0.7)
                            ],
                          ]),
                      const SizedBox(height: 12),
                      _buildBreakdownRow(
                        containerItems: breakdownValues.sublist(2, 4),
                        containerGradients: [
                          [
                            AppColors.switchContainerColorCombination1,
                            AppColors.switchContainerColorCombination2
                                .withOpacity(0.7)
                          ],
                          [
                            AppColors.redeemContainerColorCombination1,
                            AppColors.redeemContainerColorCombination2
                                .withOpacity(0.7)
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildBreakdownRow(
                        containerItems: breakdownValues.sublist(4, 6),
                        containerGradients: [
                          [
                            AppColors.swpContainerColorCombination1,
                            AppColors.swpContainerColorCombination2
                                .withOpacity(0.7)
                          ],
                          [
                            AppColors.stpContainerColorCombination1,
                            AppColors.stpContainerColorCombination2
                                .withOpacity(0.7)
                          ],
                        ],
                      ),
                      const SizedBox(height: 50),
                      _transDonutWidget(breakdownValues),
                    ],
                  );
                }

                return const SizedBox();
              },
            )),
      ],
    );
  }

  Widget aumReportSection() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.sunsetGold, AppColors.coralBlush],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: const Row(
            children: [
              Text(
                'AUM Report',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<DashboardDataCountCubit, DashboardDataCountState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is DashboardDataCountSuccessState) {
                final breakdownList = state.breakdownValues;

                return Column(
                  children: [
                    _buildBreakdownRow(
                      containerItems: breakdownList.sublist(0, 2),
                      containerGradients: [
                        [
                          AppColors.sipContainerColorCombination1,
                          AppColors.sipContainerColorCombination2
                              .withOpacity(0.7)
                        ],
                        [
                          AppColors.lumpsumContainerColorCombination1,
                          AppColors.lumpsumContainerColorCombination2
                              .withOpacity(0.7)
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildBreakdownRow(
                      containerItems: breakdownList.sublist(2, 4),
                      containerGradients: [
                        [
                          AppColors.switchContainerColorCombination1,
                          AppColors.switchContainerColorCombination2
                              .withOpacity(0.7)
                        ],
                        [
                          AppColors.redeemContainerColorCombination1,
                          AppColors.redeemContainerColorCombination2
                              .withOpacity(0.7)
                        ],
                      ],
                    ),
                    const SizedBox(height: 50),
                    _transAumDonutWidget(breakdownList),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownRow({
    List<Map<String, String>> containerItems = const [],
    required List<List<Color>> containerGradients,
  }) {
    final items = containerItems.isEmpty
        ? List.generate(
            containerGradients.length, (i) => {'title': '', 'subtitle': ''})
        : containerItems;

    return Row(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final colors = containerGradients[index];

        return Expanded(
          child: Container(
            height: 100,
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 8,
              right: index == items.length - 1 ? 0 : 8,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (item['title']!.isNotEmpty)
                    Text(
                      item['title']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.pureWhite),
                    ),
                  if (item['subtitle']!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                        Formatters().formatIndianCurrency(
                          double.tryParse(item['subtitle'] ?? '0') ?? 0,
                        ),
                        style: const TextStyle(
                            color: AppColors.pureWhite,
                            fontWeight: FontWeight.bold)),
                  ],
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoCard({
    required String icon,
    required String title,
    required String value,
    required List<Color> color,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<SelectedTypeCubit>().selectType(title);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: color,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color[1].withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(icon, height: 30),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _transDonutWidget(List<Map<String, String>> data) {
    return InvestmentChartWidget(
      data: InvestmentBreakdown.transaction(
        sip: double.tryParse(data[0]['subtitle'] ?? '0') ?? 0,
        lumpsum: double.tryParse(data[1]['subtitle'] ?? '0') ?? 0,
        switchAmount: double.tryParse(data[2]['subtitle'] ?? '0') ?? 0,
        redemption: double.tryParse(data[3]['subtitle'] ?? '0') ?? 0,
        swp: double.tryParse(data[4]['subtitle'] ?? '0') ?? 0,
        stp: double.tryParse(data[5]['subtitle'] ?? '0') ?? 0,
      ),
    );
  }

  Widget _transAumDonutWidget(List<Map<String, String>> data) {
    return InvestmentChartWidget(
      data: InvestmentBreakdown.aum(
        equity: double.tryParse(data[0]['subtitle'] ?? '0') ?? 0,
        debt: double.tryParse(data[1]['subtitle'] ?? '0') ?? 0,
        hybrid: double.tryParse(data[2]['subtitle'] ?? '0') ?? 0,
        alternate: double.tryParse(data[3]['subtitle'] ?? '0') ?? 0,
      ),
    );
  }

  void intialApiCalls() {
    context
        .read<DashMonthwiseUserDetailsGraphCubit>()
        .fetchMonthwiseUserDetailsGraph(
          filter: "yearly",
          year: _selectedUserYear,
        );
    context
        .read<DashAumReportGraphCubit>()
        .fetchAumReportGraph(year: _selectedAumYear);
    context.read<DashboardDataCountCubit>().dashboardDataCount();
    context
        .read<DashMonthwiseInvesterDetailsGraphCubit>()
        .fetchMonthwiseInvesterDetailsGraph(
          filter: "yearly",
          year: _selectedInvesterYear,
        );
    context.read<SelectedTypeCubit>().selectType("User");
    context
        .read<DashMonthwiseTransDetailsGraphCubit>()
        .fetchMonthwiseTransDetailsGraph(
          year: _selectedTransYear,
        );
    context
        .read<DashMonthwiseSipDetailsGraphCubit>()
        .fetchDashMonthwiseSipDetailsGraph(
          year: _selectedSipYear,
        );

    context.read<TransTypewiseReturnsCubit>().fetchTransTypewiseReturns();
  }
}
