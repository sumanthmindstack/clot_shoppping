import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../bloc/get_invester_list/get_invester_list_cubit.dart';
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

  void _onSearchChanged(String value) {
    setState(() {
      _searchText = value;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<GetInvesterListCubit>().fetchInvesterList();
    _scrollController.addListener(_onScroll);
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            _textBuilder(context),
            _buildTopBar(),
            _buildInvestorList(),
          ],
        ),
      ),
    );
  }

  Widget _textBuilder(BuildContext context) {
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
          const SizedBox(width: 20),
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
      onTap: () {},
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
        closeIcon: const Icon(Icons.close, color: Colors.black),
        cursorColor: Colors.black,
        searchDecoration: const InputDecoration(
          hintText: 'Type to search...',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildInvestorList() {
    return Expanded(
      child: BlocBuilder<GetInvesterListCubit, GetInvesterListState>(
        builder: (context, state) {
          final cubit = context.read<GetInvesterListCubit>();

          if (state is GetInvesterListLoadingState && cubit.investors.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetInvesterListSuccessState ||
              cubit.investors.isNotEmpty) {
            final investors = cubit.investors;
            final showLoader =
                state is GetInvesterListSuccessState && !state.hasReachedMax;

            return ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: investors.length + (showLoader ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < investors.length) {
                  return InvestorCard(
                    data: investors[index],
                    onTap: () {},
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void _onScroll() {
    if (_isNearBottom) {
      context.read<GetInvesterListCubit>().fetchInvesterList(loadMore: true);
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
