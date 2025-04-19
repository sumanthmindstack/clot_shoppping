import 'package:clot_store/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GenderAndAgeSelection extends StatelessWidget {
  const GenderAndAgeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    int _genderSelected = 0;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          _tellabouturselfText(context),
          _selectgender(context),
        ],
      ),
    ));
  }

  Widget _tellabouturselfText(BuildContext context) {
    return const Text("Tell About Ypurself",
        style: TextStyle(fontSize: 18, color: AppColors.pureWhiteColor));
  }

  Widget _selectgender(BuildContext context) {
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
  }

  Expanded _genderTile(BuildContext context,
      {required int genderIndex, required String gender}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: genderIndex == 0
                  ? AppColors.primaryColor
                  : Colors.transparent),
          child: Text(
            gender,
            style: const TextStyle(color: AppColors.pureWhiteColor),
          ),
        ),
      ),
    );
  }
}
