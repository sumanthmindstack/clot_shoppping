import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/config/routes/app_router.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/bloc/get_bank_mandates/get_bank_mandates_cubit.dart';
import '../../../../../../themes/app_colors.dart';
import 'widget_shimmers/holding_card_shimmer.dart';
import 'widgets/bank_mandate_card.dart';

class BankMandatesTab extends StatefulWidget {
  final int userId;
  const BankMandatesTab({super.key, required this.userId});

  @override
  State<BankMandatesTab> createState() => _BankMandatesTabState();
}

class _BankMandatesTabState extends State<BankMandatesTab> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  final int limit = 10;
  final int maxButtonsVisible = 3;

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
    return BlocConsumer<GetBankMandatesCubit, GetBankMandatesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetBankMandatesFailureState) {
          return const Center(
              heightFactor: 8, child: Text("No Bank Mandates Yet!"));
        }
        if (state is GetBankMandatesLoadingState) {
          return const HoldingsCardShimmer();
        }
        if (state is GetBankMandatesSuccessState) {
          final totalPages = state.getBankMandateEntity.meta.totalPages;

          return totalPages == 0
              ? const Center(
                  heightFactor: 8, child: Text("No Bank Mandates Yet!"))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 15),
                    _buildAddBankMandateButton(),
                    const SizedBox(height: 8),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      shrinkWrap: true,
                      itemCount: state.getBankMandateEntity.data.length,
                      itemBuilder: (context, index) {
                        final mandate = state.getBankMandateEntity.data[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BankMandateCard(data: mandate),
                        );
                      },
                    ),
                    if (totalPages > 1) _buildPagination(totalPages),
                  ],
                );
        }
        return const Text("No Bank Mandates Yet!");
      },
    );
  }

  Widget _buildPagination(int totalPages) {
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

  Widget _buildAddBankMandateButton() {
    return ElevatedButton.icon(
      onPressed: () {
        AutoRouter.of(context).push(AddNewMandateRoute(userId: widget.userId));
      },
      icon: const Icon(Icons.add, size: 18),
      label: const Text('Add Mandate'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return IconButton(icon: Icon(icon), onPressed: onPressed);
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

  void _fetchPage(int page) {
    setState(() => currentPage = page);
    context.read<GetBankMandatesCubit>().fetchBankMandates(
          userId: widget.userId,
          limit: limit,
          page: currentPage,
        );
  }
}
