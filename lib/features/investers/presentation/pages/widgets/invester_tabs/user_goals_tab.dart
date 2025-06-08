import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_goals/get_user_goals_details_cubit.dart';
import 'widget_shimmers/holding_card_shimmer.dart';
import 'widgets/user_goals_card.dart';

class UserGoalsTab extends StatefulWidget {
  final int userId;
  const UserGoalsTab({super.key, required this.userId});

  @override
  State<UserGoalsTab> createState() => _UserGoalsTabState();
}

class _UserGoalsTabState extends State<UserGoalsTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _fetchPage();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserGoalsDetailsCubit, GetUserGoalsDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetUserGoalsDetailsFailureState) {
          return const Center(heightFactor: 8, child: Text("No Goals Yet!"));
        }
        if (state is GetUserGoalsDetailsLoadingState) {
          return const HoldingsCardShimmer();
        }
        if (state is GetUserGoalsDetailsSuccessState) {
          return state.userGoalsEntity.result.isEmpty
              ? const Center(heightFactor: 8, child: Text("No Goals Yet!"))
              : Column(
                  children: [
                    const SizedBox(height: 10),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      shrinkWrap: true,
                      itemCount: state.userGoalsEntity.result.length,
                      itemBuilder: (context, index) {
                        final goal = state.userGoalsEntity.result[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserGoalCard(
                            data: goal,
                          ),
                        );
                      },
                    ),
                  ],
                );
        }

        return const Center(heightFactor: 8, child: Text("No Goals Yet!"));
      },
    );
  }

  void _fetchPage() {
    context.read<GetUserGoalsDetailsCubit>().fetchUserGoalsDetails(
          userId: widget.userId,
        );
  }
}
