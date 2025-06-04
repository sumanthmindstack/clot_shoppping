import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/config/routes/app_router.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/pages/shimmer/invester_card_shimmer.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../bloc/get_invester_list/get_invester_list_cubit.dart';
import '../bloc/input_selection/input_selection_cubit.dart';
import 'widgets/add_invester_screen_widget.dart';
import 'widgets/invester_card.dart';

class ManageInvestorsPage extends StatefulWidget {
  const ManageInvestorsPage({super.key});

  @override
  State<ManageInvestorsPage> createState() => _ManageInvestorsPageState();
}

class _ManageInvestorsPageState extends State<ManageInvestorsPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool _showSearchBar = false;
  int _page = 1;
  final int _limit = 10;
  bool _isFetchingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    initApiCall();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildText(context),
              _buildTopBar(),
              _buildInvestorList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return const Text(
      "Manage Investors",
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _buildAddInvestorButton(),
          _showSearchBar ? const SizedBox(width: 30) : const Spacer(),
          if (_showSearchBar)
            Expanded(child: _buildSearchBar())
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _showSearchBar = true;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAddInvestorButton() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => const AddInvestorScreenWidget(),
        ).then((_) {
          context.read<InputSelectionCubit>().deselectInput();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Icon(Icons.add, color: AppColors.pureWhite),
            SizedBox(width: 4),
            Text("Add Investor", style: TextStyle(color: AppColors.pureWhite)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      width: 300,
      child: AnimatedSearchBar(
        label: 'Search',
        controller: _searchController,
        onChanged: _onSearchChanged,
        animationDuration: const Duration(milliseconds: 300),
        labelStyle: const TextStyle(color: Colors.black54),
        searchStyle: const TextStyle(color: Colors.black),
        searchIcon: const Icon(Icons.search, color: Colors.black),
        closeIcon: const Icon(
          Icons.close,
          color: Colors.black,
          size: 18,
        ),
        cursorColor: Colors.black,
        searchDecoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 14),
          hintText: 'Type to search...',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildInvestorList() {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<GetInvesterListCubit, GetInvesterListState>(
          listener: (context, state) {
            if (state is GetInvesterListSuccessState) {
              _isFetchingMore = false;
            } else if (state is GetInvesterListFailureState) {
              _isFetchingMore = false;
              _page--;
            }
          },
          builder: (context, state) {
            if (state is GetInvesterListLoadingState && _page == 1) {
              return const InvestorCardShimmer();
            }

            if (state is GetInvesterListSuccessState) {
              return state.getInvesterListEntity.data.isEmpty
                  ? const Center(
                      child: Text("No Search Results Fund"),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: state.getInvesterListEntity.data.length,
                      itemBuilder: (context, index) {
                        return InvestorCard(
                          data: state.getInvesterListEntity.data[index],
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            AutoRouter.of(context).push(InvestorProfileRoute(
                                bankId: state.getInvesterListEntity.data[index]
                                    .userBankDetails,
                                index: index,
                                userId: state
                                    .getInvesterListEntity.data[index].userId));
                          },
                        );
                      },
                    );
            }

            if (state is GetInvesterListFailureState) {
              return Center(child: Text(state.errorMessage.toString()));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void initApiCall() {
    context
        .read<GetInvesterListCubit>()
        .fetchInvesterList(limit: _limit, page: _page);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients ||
        _isFetchingMore ||
        !_hasMore ||
        !_isNearBottom) return;

    _isFetchingMore = true;
    _page++;

    context
        .read<GetInvesterListCubit>()
        .fetchInvesterList(limit: _limit, page: _page);
  }

  bool get _isNearBottom {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchText = value;
    });
    context
        .read<GetInvesterListCubit>()
        .fetchInvesterList(page: 1, limit: 10, searchData: _searchText);
  }
}
