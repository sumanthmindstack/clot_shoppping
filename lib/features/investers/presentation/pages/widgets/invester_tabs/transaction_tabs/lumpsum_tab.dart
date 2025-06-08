import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'package:maxwealth_distributor_app/widgets/custom_dropdown_field.dart';

import '../../../../../../../constants/dropdown_constants.dart';
import '../../../../../../../widgets/customfilter_selection_widget.dart';
import '../../../../bloc/get_lumpsum_data/get_lumpsum_data_cubit.dart';
import '../widget_shimmers/fund_card_shimmer.dart';
import '../widgets/transaction_details_widget.dart';
import 'widgets/fund_card_widget.dart';

class LumpsumTab extends StatefulWidget {
  final int userId;
  const LumpsumTab({super.key, required this.userId});

  @override
  State<LumpsumTab> createState() => _LumpsumTabState();
}

class _LumpsumTabState extends State<LumpsumTab> {
  int currentPage = 1;
  final int limit = 10;
  final int maxButtonsVisible = 3;

  @override
  void initState() {
    super.initState();
    _fetchPage(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetLumpsumDataCubit, GetLumpsumDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetLumpsumDataLoadingState) {
          return const FundCardShimmerList();
        }
        if (state is GetLumpsumDataFailureState) {
          return const Center(
            heightFactor: 10,
            child: Text("No Data Available"),
          );
        }

        if (state is GetLumpsumDataSuccessState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _filterDataContainer(context),
              _buildLumpsumList(state),
            ],
          );
        }

        return const Text("No Data Found");
      },
    );
  }

  Widget _filterDataContainer(BuildContext context) {
    return CustomFilterSelectionWidget(
      filterConfigs: DropdownConstants().traansactionLumpsumFilterDropdowns,
      backgroundColor: AppColors.primaryColor,
      onOptionSelected: (selectedOption) {
        context.read<GetLumpsumDataCubit>().fetchLumpsumData(
            userId: widget.userId,
            limit: limit,
            page: currentPage,
            type: selectedOption);
      },
    );
  }

  Widget _buildLumpsumList(GetLumpsumDataSuccessState state) {
    final data = state.data.data!;
    final totalPages = state.data.meta!.totalPages;
    final pagination = _buildPagination(totalPages);

    return data.isEmpty
        ? const Center(
            heightFactor: 5,
            child: Text("No Search results Found"),
          )
        : Column(
            children: [
              ...data.map((item) => FundCard(
                    transactionBasketItemId: item.transactionBasketItemId ?? 0,
                    amount: item.amount ?? "0.00",
                    fundName: item.fundName,
                    scheme: item.scheme,
                    state: item.state ?? "",
                  )),
              if (totalPages > 1) pagination,
            ],
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
    context.read<GetLumpsumDataCubit>().fetchLumpsumData(
        userId: widget.userId, limit: limit, page: page, type: "");
  }
}
