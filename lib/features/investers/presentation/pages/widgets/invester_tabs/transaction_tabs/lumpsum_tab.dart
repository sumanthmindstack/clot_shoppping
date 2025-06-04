import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/get_lumpsum_data/get_lumpsum_data_cubit.dart';
import 'widgets/fund_card_widget.dart';

class LumpsumTab extends StatefulWidget {
  final int userId;
  const LumpsumTab({super.key, required this.userId});

  @override
  State<LumpsumTab> createState() => _LumpsumTabState();
}

class _LumpsumTabState extends State<LumpsumTab> {
  @override
  void initState() {
    context
        .read<GetLumpsumDataCubit>()
        .fetchLumpsumData(userId: widget.userId, limit: 10, page: 1, type: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetLumpsumDataCubit, GetLumpsumDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is GetLumpsumDataSuccessState) {
          final response = state.data.data;
          return Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.data.data!.length,
                itemBuilder: (context, index) {
                  final item = response![index];
                  return FundCard(item: item);
                },
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
