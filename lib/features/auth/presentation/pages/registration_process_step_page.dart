import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/mfd_flow_check/mfd_flow_check_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/ria_flow_check/ria_flow_check_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/pages/register_as_mfd/arn_details_page.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/pages/register_as_mfd/contact_details_page.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/pages/register_as_mfd/euin_details_page.dart';
import '../../../../constants/meta_strings.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/animate_page_widget.dart';
import '../bloc/registration_flow/registration_flow_cubit.dart';
import 'register_as_mfd/address_details_page.dart';
import 'register_as_mfd/registration_page.dart';
import 'register_as_ria/contact_details_page_ria.dart';
import 'register_as_ria/fee_collection_page_ria.dart';
import 'register_as_ria/ria_details_page_ria.dart';

@RoutePage()
class RegistrationProcessStepPage extends StatefulWidget {
  const RegistrationProcessStepPage({super.key});

  @override
  State<RegistrationProcessStepPage> createState() =>
      _RegistrationProcessStepPageState();
}

class _RegistrationProcessStepPageState
    extends State<RegistrationProcessStepPage> {
  final PageController pageController = PageController();
  late int intialIndex;
  final List<String> mFDheaders = [
    RegistrationScreenStrings.registrationMFDText,
    RegistrationScreenStrings.arnDetailsMFD,
    RegistrationScreenStrings.euinDetailsMFD,
    RegistrationScreenStrings.addressDetailsMFD,
    RegistrationScreenStrings.contactDetailsMFD,
  ];
  final List<String> rIAheaders = [
    RegistrationScreenStrings.registrationMFDText,
    RegistrationScreenStrings.arnDetailsMFD,
    RegistrationScreenStrings.euinDetailsMFD,
    RegistrationScreenStrings.addressDetailsMFD,
    RegistrationScreenStrings.contactDetailsMFD,
  ];
  late final List<Widget> _screensMFD;
  late final List<Widget> _screensRIA;
  late final List<String> _mFDHeadings;
  late final List<String> _rIAHeadings;

  @override
  void initState() {
    _screensMFD = [
      RegistrationScreen(type: "MFD", pageController: pageController),
      ArnDetailsPage(pageController: pageController),
      EuinDetailsPage(pageController: pageController),
      AddressDetailsPage(pageController: pageController),
      ContactDetailsPage(pageController: pageController),
    ];
    _screensRIA = [
      RegistrationScreen(type: "RIA", pageController: pageController),
      RiaDetailsPageRia(pageController: pageController),
      ContactDetailsPageRia(pageController: pageController),
      FeeCollectionPageRia(pageController: pageController),
    ];
    _mFDHeadings = [
      "Register To Continue",
      "ARN Details",
      "Euin Details",
      "Address Details",
      "Contact Details",
    ];
    _rIAHeadings = [
      "Register To Continue",
      "RIA Details",
      "Contact Details",
      "RIA FEE Collection Bank",
    ];
    context.read<MfdFlowCheckCubit>().setMFDRegistrationFlowCheck(-1);
    context.read<RiaFlowCheckCubit>().setRIARegistrationFlowCheck(-1);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimatePageWidget(
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                BlocBuilder<RegistrationFlowCubit, bool>(
                  builder: (context, state) {
                    print("here is the state MFD OR RIA ----->${state}");
                    return state == false
                        ? _buildRIAStepper(context, isSmallScreen)
                        : _buildMFDStepper(context, isSmallScreen);
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: BlocBuilder<RegistrationFlowCubit, bool>(
                    builder: (context, state) {
                      return SizedBox(
                        height: screenHeight * 0.8,
                        child: PageView.builder(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              state ? _screensMFD.length : _screensRIA.length,
                          itemBuilder: (context, index) {
                            return AnimatePageWidget(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      state
                                          ? _mFDHeadings[index]
                                          : _rIAHeadings[index],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    state
                                        ? _screensMFD[index]
                                        : _screensRIA[index],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMFDStepper(BuildContext context, bool isSmallScreen) {
    return BlocBuilder<MfdFlowCheckCubit, List<int>>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_mFDHeadings.length, (index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: state.contains(index)
                      ? const Icon(
                          Icons.verified_outlined,
                          color: AppColors.pureWhite,
                        )
                      : Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 60,
                  child: Text(
                    _mFDHeadings[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 10 : 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _buildRIAStepper(BuildContext context, bool isSmallScreen) {
    return BlocBuilder<RiaFlowCheckCubit, List<int>>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_rIAHeadings.length, (index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: state.contains(index)
                      ? const Icon(
                          Icons.verified_outlined,
                          color: AppColors.pureWhite,
                        )
                      : Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 60,
                  child: Text(
                    _rIAHeadings[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 10 : 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
