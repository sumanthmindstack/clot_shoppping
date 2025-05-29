import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/config/routes/app_router.dart';
import 'package:maxwealth_distributor_app/constants/dropdown_constants.dart';
import 'package:maxwealth_distributor_app/widgets/custom_dropdown_field.dart';

import '../../../../../common/validator.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../widgets/custom_loading_widget.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../../widgets/submit_button_widget.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../bloc/pass_id_pagetopage/pass_id_pagetopage_cubit.dart';
import '../../bloc/ria_bank/ria_bank_cubit.dart';
import '../../bloc/ria_flow_check/ria_flow_check_cubit.dart';

class FeeCollectionPageRia extends StatefulWidget {
  final PageController? pageController;

  const FeeCollectionPageRia({super.key, this.pageController});

  @override
  State<FeeCollectionPageRia> createState() => _FeeCollectionPageRiaState();
}

class _FeeCollectionPageRiaState extends State<FeeCollectionPageRia> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController fundTransNotiEmailontroller =
      TextEditingController();
  final TextEditingController mICRNoController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController beneficiaryNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundGrey,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _accountNumber(context),
                const SizedBox(height: 15),
                _ifscCode(context),
                const SizedBox(height: 15),
                _fundTranferNotificationEmail(context),
                const SizedBox(height: 15),
                _mICRNumber(context),
                const SizedBox(height: 15),
                _accountType(context),
                const SizedBox(height: 15),
                _bankName(context),
                const SizedBox(height: 15),
                _beneficiaryName(context),
                const SizedBox(height: 15),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SubmitButtonWidget(
                            label: "Prev",
                            onPressed: () {
                              widget.pageController!.jumpToPage(2);
                              context
                                  .read<RiaFlowCheckCubit>()
                                  .setRIARegistrationFlowCheck(1);
                            },
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        BlocConsumer<RiaBankCubit, RiaBankState>(
                          listener: (context, state) {
                            if (state is RiaBankSuccessState) {
                              _showSnackSuccess(context);
                              context
                                  .read<RiaFlowCheckCubit>()
                                  .setRIARegistrationFlowCheck(3);
                              AutoRouter.of(context)
                                  .push(const DistributorAgreementRoute());
                            } else if (state is RiaBankFailureState) {
                              _showSnackFailure(
                                  context, state.errorMessage.toString());
                            }
                          },
                          builder: (context, state) {
                            if (state is RiaBankSuccessState) {
                              return const Expanded(
                                child: CustomLoadingButton(
                                    color: AppColors.primaryColor),
                              );
                            }
                            return Expanded(
                              child: SubmitButtonWidget(
                                  label: "Next Step",
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      final riaId = context
                                          .read<PassIdPagetopageCubit>()
                                          .getId;
                                      final id = context
                                          .read<PassIdPagetopageCubit>()
                                          .getUserId;
                                      context
                                          .read<RiaBankCubit>()
                                          .uploadRiaBank(
                                              accountNumber:
                                                  accountNumberController.text,
                                              accountType:
                                                  accountTypeController.text,
                                              bankName: bankNameController.text,
                                              bankProof: "",
                                              benificiaryName:
                                                  beneficiaryNameController
                                                      .text,
                                              branchName: "",
                                              fundTransferNotificationEmail:
                                                  fundTransNotiEmailontroller
                                                      .text,
                                              ifscCode: ifscCodeController.text,
                                              micrCode: mICRNoController.text,
                                              riaId: riaId,
                                              userId: id);
                                    }
                                  },
                                  color: AppColors.primaryColor),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _accountNumber(BuildContext context) {
    return TextFieldWidget(
      labelText: "Account Number",
      hintText: "Enter Account Number",
      controller: accountNumberController,
      isNumberOrString: TextInputType.number,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d{0,12}$'),
        ),
      ],
      validator: Validators.validateBankAccountNumber,
    );
  }

  Widget _ifscCode(BuildContext context) {
    return TextFieldWidget(
      labelText: "IFSC Code",
      hintText: "Enter IFSC Code",
      controller: ifscCodeController,
      textCapitalization: TextCapitalization.characters,
      isNumberOrString: TextInputType.text,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^[A-Z]{0,4}0{0,1}[A-Z0-9]{0,6}$'),
        ),
      ],
      validator: Validators.validateIFSCCode,
    );
  }

  Widget _fundTranferNotificationEmail(BuildContext context) {
    return TextFieldWidget(
      labelText: "Fund Transfer notification E-mail",
      hintText: "Enter Email",
      controller: fundTransNotiEmailontroller,
      isNumberOrString: TextInputType.emailAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9@._+-]'),
        ),
      ],
      validator: Validators.validateEmail,
    );
  }

  Widget _mICRNumber(BuildContext context) {
    return TextFieldWidget(
      labelText: "MICR No",
      hintText: "Enter the micrno",
      controller: mICRNoController,
      isNumberOrString: TextInputType.number,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d{0,9}$'),
        ),
      ],
      validator: Validators.validateMICR,
    );
  }

  Widget _accountType(BuildContext context) {
    return CustomDropdownField(
      dropdowns: DropdownConstants().dropdowns,
      onSelectionChanged: (value) {},
    );
  }

  Widget _bankName(BuildContext context) {
    return TextFieldWidget(
      labelText: "Bank Name",
      hintText: "Enter bank name",
      controller: bankNameController,
      isNumberOrString: TextInputType.text,
      textCapitalization: TextCapitalization.characters,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9 .'-]")),
        LengthLimitingTextInputFormatter(50),
      ],
      validator: Validators.validateBankAccountName,
    );
  }

  Widget _beneficiaryName(BuildContext context) {
    return TextFieldWidget(
      labelText: "Beneficiary Name",
      hintText: "Enter beneficiary name",
      controller: beneficiaryNameController,
      isNumberOrString: TextInputType.text,
      textCapitalization: TextCapitalization.characters,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z .'-]")),
        LengthLimitingTextInputFormatter(50),
      ],
      validator: Validators.validateBeneficiaryName,
    );
  }

  void _showSnackSuccess(BuildContext context) {
    CustomSnackBar.show(
      context,
      message: "Bank Details Uploaded Successful",
      backgroundColor: AppColors.primaryColor,
      borderRadius: 16,
    );
  }

  void _showSnackFailure(BuildContext context, String errorMessage) {
    CustomSnackBar.show(
      context,
      message: errorMessage,
      backgroundColor: AppColors.errorRed,
      borderRadius: 16,
    );
  }
}
