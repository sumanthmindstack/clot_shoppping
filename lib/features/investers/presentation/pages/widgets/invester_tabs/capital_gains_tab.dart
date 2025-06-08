import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/bloc/get_capital_gains/get_capital_gains_cubit.dart';
import '../../../../../../widgets/units_selection_widget.dart';
import 'widget_shimmers/holding_card_shimmer.dart';
import 'widgets/capital_gains_card.dart';

class CapitalGainsTab extends StatefulWidget {
  final int userId;
  const CapitalGainsTab({super.key, required this.userId});

  @override
  State<CapitalGainsTab> createState() => _CapitalGainsTabState();
}

class _CapitalGainsTabState extends State<CapitalGainsTab> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  final int limit = 10;
  final int maxButtonsVisible = 3;
  String _selectedScale = 'Actual';

  @override
  void initState() {
    _fetchPage(currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCapitalGainsCubit, GetCapitalGainsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetCapitalGainsFailureState) {
          return const Text("No Capital Gains Found!");
        }
        if (state is GetCapitalGainsLoadingState) {
          return const HoldingsCardShimmer();
        }
        if (state is GetCapitalGainsSuccessState) {
          final totalPages = state.getCapitalGainsEntity.meta?.totalPages;

          return Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return totalPages == 0
                      ? const Center(
                          heightFactor: 8,
                          child: Text("No Capital Gains Found!"))
                      : Column(
                          children: [
                            const SizedBox(height: 15),
                            _buildScaleSelector(),
                            const SizedBox(height: 10),
                            Column(
                              children: state.getCapitalGainsEntity.result!
                                  .map((gain) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CapitalGainsCard(
                                    data: gain,
                                    selectedScale: _selectedScale,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                },
              ),
              if (totalPages! > 1) _buildPagination(totalPages),
            ],
          );
        }

        return const Text("No Capital Gains Found!");
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
      scales: scales,
    );
  }

  Widget _buildPagination(int totalPages) {
    if (totalPages == 0) return const SizedBox.shrink();

    final startPage =
        ((currentPage - 1) ~/ maxButtonsVisible) * maxButtonsVisible + 1;
    final endPage = (startPage + maxButtonsVisible - 1).clamp(1, totalPages);

    final pageCount = endPage - startPage + 1;
    if (pageCount <= 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildArrowButton(
            icon: Icons.chevron_left,
            onPressed:
                currentPage > 1 ? () => _fetchPage(currentPage - 1) : null,
          ),
          ...List.generate(pageCount, (index) {
            final page = startPage + index;
            final isSelected = page == currentPage;
            return _buildPageButton(page, isSelected);
          }),
          _buildArrowButton(
            icon: Icons.chevron_right,
            onPressed: currentPage < totalPages
                ? () => _fetchPage(currentPage + 1)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }

  void _fetchPage(int page) {
    setState(() => currentPage = page);
    context.read<GetCapitalGainsCubit>().fetchCapitalGains(
        userId: widget.userId, limit: limit, page: currentPage);
  }

  Widget _buildPageButton(int page, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () => _fetchPage(page),
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.blue : Colors.transparent,
          minimumSize: const Size(28, 28),
          padding: EdgeInsets.zero,
        ),
        child: Text(page.toString()),
      ),
    );
  }
}
