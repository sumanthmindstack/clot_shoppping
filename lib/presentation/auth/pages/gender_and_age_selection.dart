import 'package:auto_route/auto_route.dart';
import 'package:clot_store/presentation/auth/bloc/age_selection_cubit/age_selection_cubit.dart';
import 'package:clot_store/presentation/auth/bloc/gender_selection_cubit.dart';
import 'package:clot_store/presentation/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../get_it/get_it.dart';
import '../bloc/gender_selection_cubit.dart';

@RoutePage()
class GenderAndAgeSelectionPage extends StatelessWidget
    implements AutoRouteWrapper {
  const GenderAndAgeSelectionPage({super.key});
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => getIt<GenderSelectionCubit>(),
      ),
      BlocProvider(
        create: (context) => getIt<AgeSelectionCubit>(),
      ),
    ], child: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tellabouturselfText(context),
            const SizedBox(
              height: 20,
            ),
            _hodoYouShopForText(context),
            const SizedBox(
              height: 20,
            ),
            _selectgender(context),
            const SizedBox(
              height: 40,
            ),
            _howOldAreYou(context),
            const SizedBox(
              height: 20,
            ),
            _ageRangeContainer(context),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  Widget _tellabouturselfText(BuildContext context) {
    return const Text("Tell us About yourself",
        style: TextStyle(fontSize: 24, color: AppColors.pureWhiteColor));
  }

  Widget _hodoYouShopForText(BuildContext contxet) {
    return const Text(
      "Who do you shop for ?",
      style: TextStyle(fontSize: 17, color: AppColors.pureWhiteColor),
    );
  }

  Widget _howOldAreYou(BuildContext context) {
    return const Text(
      "How old are you ?",
      style: TextStyle(fontSize: 17, color: AppColors.pureWhiteColor),
    );
  }

  Widget _selectgender(BuildContext context) {
    return BlocBuilder<GenderSelectionCubit, int>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _genderTile(context, gender: "Male", genderIndex: 0),
                _genderTile(context, gender: "Female", genderIndex: 1),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _ageRangeContainer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AgeSelectionCubit>().selectAge();
      },
      child: BlocBuilder<AgeSelectionCubit, String>(
        builder: (context, state) {
          return Container(
            height: 50,
            decoration: const BoxDecoration(
                color: AppColors.dropDownBacgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 20,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded _genderTile(BuildContext context,
      {required int genderIndex, required String gender}) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () async {
            context.read<GenderSelectionCubit>().selectGenderValue(genderIndex);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: context.read<GenderSelectionCubit>().selectedIndex ==
                        genderIndex
                    ? AppColors.primaryColor
                    : Colors.transparent),
            child: Center(
              child: Text(
                gender,
                style: const TextStyle(color: AppColors.pureWhiteColor),
              ),
            ),
          ),
        ));
  }
}
