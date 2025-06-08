import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/bloc/get_holding_details/get_holding_details_cubit.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/pages/widgets/invester_tabs/widgets/holdings_card.dart';

import '../../../../../../widgets/units_selection_widget.dart';
import 'widget_shimmers/holding_card_shimmer.dart';

class HoldingsTab extends StatefulWidget {
  final int userId;
  const HoldingsTab({super.key, required this.userId});

  @override
  State<HoldingsTab> createState() => _HoldingsTabState();
}

class _HoldingsTabState extends State<HoldingsTab> {
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
    return BlocConsumer<GetHoldingDetailsCubit, GetHoldingDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetHoldingDetailsFailureState) {
          return const Text("No Holdings Yet!");
        }
        if (state is GetHoldingDetailsLoadingState) {
          return const HoldingsCardShimmer();
        }
        if (state is GetHoldingDetailsSuccessState) {
          final totalPages = state.data.pagination.totalPages;

          return Column(
            children: [
              const SizedBox(height: 15),
              _buildScaleSelector(),
              const SizedBox(height: 10),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: state.data.data.folios.map((folio) {
                      return Column(
                        children: folio.schemes.map((scheme) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HoldingsCard(
                              data: scheme,
                              selectedScale: _selectedScale,
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  );
                },
              ),
              if (totalPages > 1) _buildPagination(totalPages),
            ],
          );
        }

        return const Text("No Holdings Yet!");
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
    context.read<GetHoldingDetailsCubit>().fetchHoldingDetails(
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
