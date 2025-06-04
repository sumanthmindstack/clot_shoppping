import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'package:maxwealth_distributor_app/widgets/custom_loading_widget.dart';
import 'package:maxwealth_distributor_app/widgets/custom_snackbar.dart';
import 'package:maxwealth_distributor_app/widgets/text_field_widget.dart';

import '../../../../../common/validator.dart';
import '../../../../../gen/assets.gen.dart';
import '../../bloc/check_kyc/check_kyc_cubit.dart';
import '../../bloc/get_kyc_details/get_kyc_details_cubit.dart';
import '../../bloc/get_kyc_user_list/get_kyc_user_list_cubit.dart';
import '../../bloc/input_selection/input_selection_cubit.dart';
import '../../bloc/show_kyc_message/show_kyc_message_cubit.dart';
import 'kyc_status_banner.dart';

class AddInvestorScreenWidget extends StatefulWidget {
  const AddInvestorScreenWidget({super.key});

  @override
  State<AddInvestorScreenWidget> createState() =>
      _AddInvestorScreenWidgetState();
}

class _AddInvestorScreenWidgetState extends State<AddInvestorScreenWidget> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  SelectedUser? selectedUser;
  final _formKey = GlobalKey<FormState>();
  bool isKycComplete = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        context.read<InputSelectionCubit>().deselectInput();
      },
      child: DraggableScrollableSheet(
        shouldCloseOnMinExtent: true,
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sheetHandle(),
                    const SizedBox(height: 24),
                    _titleText(),
                    const SizedBox(height: 24),
                    _kycSection(),
                    const SizedBox(height: 20),
                    selectedUser != null
                        ? _selectedUserCard(selectedUser!)
                        : _selectUserInputField(),
                    const SizedBox(height: 8),
                    _searchKycUserList(context),
                    const SizedBox(height: 8),
                    _panInputField(),
                    const SizedBox(height: 20),
                    _kycButton(),
                    const SizedBox(height: 30),
                    _footerButtons(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sheetHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _titleText() {
    return const Center(
      child: Text(
        "New Investor",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _kycSection() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: SvgPicture.asset(Assets.images.kycCheckImage.path),
          ),
          const Text(
            "CHECK KYC",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectUserInputField() {
    return TextFieldWidget(
      validator: Validators.validateUserSelection,
      controller: _searchController,
      isNumberOrString: TextInputType.multiline,
      labelText: "Select User (search) *",
      hintText: "Search User..",
      onChanged: (value) {
        value.trim().isEmpty
            ? context.read<InputSelectionCubit>().deselectInput()
            : {
                context.read<InputSelectionCubit>().selectInput(),
                context.read<GetKycUserListCubit>().fetchKycUserList(
                      searchTerm: value,
                      limit: 20,
                      page: 1,
                    ),
              };
      },
      textInputFormat: const [],
    );
  }

  Widget _panInputField() {
    return TextFieldWidget(
      labelText: "PAN",
      hintText: "PAN Number",
      textCapitalization: TextCapitalization.characters,
      validator: Validators.validatePanNumber,
      isNumberOrString: TextInputType.multiline,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[A-Z\d]')),
        LengthLimitingTextInputFormatter(10),
      ],
      controller: _panController,
    );
  }

  Widget _kycButton() {
    return BlocConsumer<GetKycDetailsCubit, GetKycDetailsState>(
      listener: (context, state) {
        if (state is GetKycDetailsSuccessState) {
          final isComplete = state.kycDetails.data.isKycComplete;
          context
              .read<KycMessageCubit>()
              .showMessageForDuration(const Duration(seconds: 10), isComplete);
          setState(() {
            isKycComplete = isComplete;
          });
        }
      },
      builder: (context, getKycState) {
        return BlocConsumer<CheckKycCubit, CheckKycState>(
          listener: (context, state) {
            if (state is CheckKycFailureState) {
              CustomSnackBar.show(context,
                  message: state.errorMessage.toString());
            }
            if (state is CheckKycSuccessState) {
              context.read<GetKycDetailsCubit>().fetchKycDetails(
                    userId: int.parse(selectedUser!.userId),
                  );
            }
          },
          builder: (context, checkKycState) {
            if (checkKycState is CheckKycLoadingState) {
              return const CustomLoadingButton(color: AppColors.primaryColor);
            }

            return Column(
              children: [
                BlocBuilder<KycMessageCubit, bool?>(
                  builder: (context, showMessage) {
                    return showMessage != null
                        ? KYCStatusBanner(
                            isCompliant: showMessage,
                            pan: selectedUser?.pan ?? "---",
                          )
                        : const SizedBox();
                  },
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context.read<CheckKycCubit>().checkKyc(
                              pan: _panController.text,
                              userId: int.parse(selectedUser!.userId),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF276EF1),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Check KYC",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _footerButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: isKycComplete && selectedUser != null
                ? () {
                    Navigator.pop(context, selectedUser);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isKycComplete ? Colors.blue.shade100 : Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              "Continue",
              style: TextStyle(
                color: isKycComplete ? Colors.black : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchKycUserList(BuildContext context) {
    return BlocBuilder<InputSelectionCubit, bool>(
      builder: (context, isSearchRequired) {
        return !isSearchRequired
            ? const SizedBox()
            : BlocConsumer<GetKycUserListCubit, GetKycUserListState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetKycUserListSuccessState) {
                    final data = state.kycUserList.data ?? [];
                    return data.isEmpty
                        ? const SizedBox(
                            height: 30,
                            child: Text("No Search Found"),
                          )
                        : SizedBox(
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return _userTile(
                                  userId: data[index].id.toString(),
                                  pan: data[index].userOnboardingDetails?.pan ??
                                      "---",
                                  index: index,
                                  name: data[index].fullName,
                                  email: data[index].email,
                                  mobile: data[index].mobile,
                                );
                              },
                            ),
                          );
                  }
                  return const SizedBox();
                },
              );
      },
    );
  }

  Widget _userTile({
    required String name,
    required String email,
    required String mobile,
    required String pan,
    required int index,
    required String userId,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _panController.text = pan;
          selectedUser = SelectedUser(
            pan: pan,
            userId: userId,
            fullName: name,
            email: email,
            mobile: mobile,
          );
          context.read<InputSelectionCubit>().deselectInput();
          isKycComplete = false;
          _searchController.clear();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                text: "Email ID: ",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: email,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: "Mobile: ",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: mobile,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedUserCard(SelectedUser user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Selected User:", style: TextStyle(fontSize: 14)),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                ),
                onPressed: () {
                  setState(() {
                    selectedUser = null;
                  });
                },
                child: const Text(
                  "Reselect User",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(user.fullName,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          Text("Email: ${user.email}"),
          Text("Mobile: ${user.mobile}"),
        ],
      ),
    );
  }
}

class SelectedUser {
  final String userId;
  final String fullName;
  final String email;
  final String mobile;
  final String? pan;

  SelectedUser({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.pan,
  });
}
