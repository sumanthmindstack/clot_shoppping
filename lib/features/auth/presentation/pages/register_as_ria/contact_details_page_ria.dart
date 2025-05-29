import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/contact_details/contact_details_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/find_one/find_one_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/pass_id_pagetopage/pass_id_pagetopage_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/ria_patch/ria_patch_cubit.dart';

import '../../../../../common/validator.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../widgets/code_textfield.dart';
import '../../../../../widgets/custom_check_box.dart';
import '../../../../../widgets/custom_loading_widget.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../../widgets/submit_button_widget.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../../domain/entities/find_one_entity.dart';
import '../../bloc/mfd_flow_check/mfd_flow_check_cubit.dart';
import '../../bloc/ria_contact_details/ria_contact_details_cubit.dart';
import '../../bloc/ria_flow_check/ria_flow_check_cubit.dart';

class ContactDetailsPageRia extends StatefulWidget {
  final PageController? pageController;
  const ContactDetailsPageRia({super.key, this.pageController});

  @override
  State<ContactDetailsPageRia> createState() => _ContactDetailsPageRiaState();
}

class _ContactDetailsPageRiaState extends State<ContactDetailsPageRia> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController stdCodeController = TextEditingController();
  final TextEditingController landlineNoController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController primaryMobNoController = TextEditingController();
  final TextEditingController alternativeCountryCodeController =
      TextEditingController();
  final TextEditingController alternativeMobNoController =
      TextEditingController();
  final TextEditingController primaryEmailController = TextEditingController();
  final TextEditingController primaryAlternateEmailController =
      TextEditingController();
  final TextEditingController stdCodecommunicationController =
      TextEditingController();
  final TextEditingController landlineNocommunicationController =
      TextEditingController();
  final TextEditingController countryCodecommunicationController =
      TextEditingController();
  final TextEditingController primaryMobNocommunicationController =
      TextEditingController();
  final TextEditingController alternativeCountryCodecommunicationController =
      TextEditingController();
  final TextEditingController alternativeMobNocommunicationController =
      TextEditingController();
  final TextEditingController primaryEmailcommunicationController =
      TextEditingController();
  final TextEditingController primaryAlternateEmailcommunicationController =
      TextEditingController();
  bool _isSameAsCorrespondence = false;
  @override
  void initState() {
    final id = context.read<PassIdPagetopageCubit>().getId;
    context.read<FindOneCubit>().findOne(id: id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindOneCubit, FindOneState>(
      listener: (context, state) {
        if (state is FindOneSuccessState) {
          _setIntialState(state.findOneEntity);
        }
      },
      builder: (context, state) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  CustomCheckBox(
                    title: "Same as Correspondence Details",
                    onChanged: (value) {
                      _isSameAsCorrespondence = value;
                      value
                          ? _copyPermanentToCommunicationContact(true)
                          : _copyPermanentToCommunicationContact(false);
                    },
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _correspondenceText(context),
                          const SizedBox(height: 15),
                          _primaryLandLine(context),
                          const SizedBox(height: 15),
                          _primaryPhoneNumber(context),
                          const SizedBox(height: 15),
                          _alternatePhoneNumber(context),
                          const SizedBox(height: 15),
                          _primaryEmail(context),
                          const SizedBox(height: 15),
                          _primaryAlternateEmail(context),
                          const SizedBox(height: 15),
                          const SizedBox(height: 15),
                          _communicationContactDetailsText(context),
                          const SizedBox(height: 15),
                          _primaryLandLineCommunication(context),
                          const SizedBox(height: 15),
                          _primaryPhoneNumberCommunication(context),
                          const SizedBox(height: 15),
                          _alternatePhoneNumberCommunication(context),
                          const SizedBox(height: 15),
                          _primaryEmailCommunication(context),
                          const SizedBox(height: 15),
                          _primaryAlternateEmailCommunication(context),
                          const SizedBox(height: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SubmitButtonWidget(
                                      label: "Prev",
                                      onPressed: () {
                                        widget.pageController!.jumpToPage(1);
                                        context
                                            .read<RiaFlowCheckCubit>()
                                            .setRIARegistrationFlowCheck(0);
                                      },
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  BlocConsumer<RiaContactDetailsCubit,
                                      RiaContactDetailsState>(
                                    listener: (context, state) {
                                      if (state
                                          is RiaContactDetailsSuccessState) {
                                        _showSnackSuccess(context);
                                        widget.pageController!.jumpToPage(3);

                                        context
                                            .read<RiaFlowCheckCubit>()
                                            .setRIARegistrationFlowCheck(2);
                                      }
                                      if (state
                                          is RiaContactDetailsFailureState) {
                                        _showSnackFailure(context,
                                            state.errorMessage!.toString());
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state
                                          is RiaContactDetailsLoadingState) {
                                        return const Expanded(
                                          child: CustomLoadingButton(
                                              color: AppColors.primaryColor),
                                        );
                                      }
                                      return Expanded(
                                        child: SubmitButtonWidget(
                                          label: "Next Step",
                                          onPressed: () {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              final id = context
                                                  .read<PassIdPagetopageCubit>()
                                                  .getId;
                                              context.read<RiaContactDetailsCubit>().uploadRiaContactDetails(
                                                  id: id.toString(),
                                                  primaryLandline: int.parse(
                                                      landlineNoController
                                                          .text),
                                                  primaryMobile: int.parse(
                                                      primaryMobNoController
                                                          .text),
                                                  alternateMobile: int.parse(
                                                      alternativeMobNoController
                                                          .text),
                                                  primaryEmail:
                                                      primaryEmailController
                                                          .text,
                                                  alternateEmail:
                                                      primaryAlternateEmailController
                                                          .text,
                                                  communicationPrimaryLandline:
                                                      int.parse(
                                                          landlineNocommunicationController
                                                              .text),
                                                  communicationPrimaryMobile:
                                                      int.parse(
                                                          primaryMobNocommunicationController.text),
                                                  communicationAlternateMobile: int.parse(alternativeMobNocommunicationController.text),
                                                  communicationPrimaryEmail: primaryEmailcommunicationController.text,
                                                  communicationAlternateEmail: primaryAlternateEmailcommunicationController.text);
                                            }
                                          },
                                          color: AppColors.primaryColor,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _correspondenceText(BuildContext context) {
    return const Text(
      "Correspondence Contact Details",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _communicationContactDetailsText(BuildContext context) {
    return const Text(
      "Communication Contact Details",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _primaryLandLine(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: CodeTextfield(
                hintText: "STD Code",
                // validator: Validators.validateStdCode,
                controller: stdCodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d{0,5}')),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFieldWidget(
                labelText: "Primary Landline",
                hintText: "Landline Number",
                validator: Validators.validatePrimaryLandline,
                isNumberOrString: TextInputType.number,
                onChanged: (value) {},
                textInputFormat: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9\- ]{0,15}$'),
                  ),
                ],
                controller: landlineNoController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _primaryPhoneNumber(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: CodeTextfield(
                hintText: "Country Code",
                // validator: Validators.validateCountryCode,
                controller: countryCodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\??\d{0,4}$'))
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFieldWidget(
                labelText: "Primary Mobile",
                hintText: "Mobile Number",
                validator: Validators.validateMobileNumber,
                isNumberOrString: TextInputType.number,
                onChanged: (value) {},
                textInputFormat: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: primaryMobNoController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _alternatePhoneNumber(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: CodeTextfield(
                hintText: "Country Code",
                // validator: Validators.validateCountryCode,
                controller: alternativeCountryCodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\+?\d{0,4}')),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFieldWidget(
                labelText: "Alternate Mobile",
                hintText: "Alternate Mobile Number",
                validator: Validators.validateMobileNumber,
                isNumberOrString: TextInputType.number,
                onChanged: (value) {},
                textInputFormat: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: alternativeMobNoController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _primaryEmail(BuildContext context) {
    return TextFieldWidget(
        labelText: "Primary E-mail",
        hintText: "Enter Primary Email",
        validator: Validators.validateEmail,
        isNumberOrString: TextInputType.emailAddress,
        onChanged: (value) {},
        textInputFormat: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9@._\-]'),
          ),
        ],
        controller: primaryEmailController);
  }

  Widget _primaryAlternateEmail(BuildContext context) {
    return TextFieldWidget(
        labelText: "Primary E-mail",
        hintText: "Enter Primary Email",
        validator: Validators.validateEmail,
        isNumberOrString: TextInputType.emailAddress,
        onChanged: (value) {},
        textInputFormat: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9@._\-]'),
          ),
        ],
        controller: primaryAlternateEmailController);
  }

  Widget _primaryLandLineCommunication(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: CodeTextfield(
                hintText: "STD Code",
                // validator: Validators.validateStdCode,
                controller: stdCodecommunicationController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d{0,5}')),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFieldWidget(
                labelText: "Primary Landline",
                hintText: "Landline Number",
                validator: Validators.validatePrimaryLandline,
                isNumberOrString: TextInputType.number,
                onChanged: (value) {},
                textInputFormat: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9\- ]{0,15}$'),
                  ),
                ],
                controller: landlineNocommunicationController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _primaryPhoneNumberCommunication(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: CodeTextfield(
                hintText: "Country Code",
                // validator: Validators.validateCountryCode,
                controller: countryCodecommunicationController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\+?\d{0,4}')),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFieldWidget(
                labelText: "Primary Mobile",
                hintText: "Mobile Number",
                validator: Validators.validateMobileNumber,
                isNumberOrString: TextInputType.number,
                onChanged: (value) {},
                textInputFormat: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: primaryMobNocommunicationController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _alternatePhoneNumberCommunication(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: CodeTextfield(
                hintText: "Country Code",
                // validator: Validators.validateCountryCode,
                controller: alternativeCountryCodecommunicationController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\+?\d{0,4}')),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFieldWidget(
                labelText: "Alternate Mobile",
                hintText: "Alternate Mobile Number",
                validator: Validators.validateMobileNumber,
                isNumberOrString: TextInputType.number,
                onChanged: (value) {},
                textInputFormat: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: alternativeMobNocommunicationController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _primaryEmailCommunication(BuildContext context) {
    return TextFieldWidget(
        labelText: "Primary E-mail",
        hintText: "Enter Primary Email",
        validator: Validators.validateEmail,
        isNumberOrString: TextInputType.emailAddress,
        onChanged: (value) {},
        textInputFormat: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9@._\-]'),
          ),
        ],
        controller: primaryEmailcommunicationController);
  }

  Widget _primaryAlternateEmailCommunication(BuildContext context) {
    return TextFieldWidget(
        labelText: "Alternate E-mail",
        hintText: "Enter Alternate Email",
        validator: Validators.validateEmail,
        isNumberOrString: TextInputType.emailAddress,
        onChanged: (value) {},
        textInputFormat: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9@._\-]'),
          ),
        ],
        controller: primaryAlternateEmailcommunicationController);
  }

  void _copyPermanentToCommunicationContact([bool? shouldCopy]) {
    stdCodecommunicationController.text =
        shouldCopy == true ? stdCodeController.text : '';
    landlineNocommunicationController.text =
        shouldCopy == true ? landlineNoController.text : '';
    countryCodecommunicationController.text =
        shouldCopy == true ? countryCodeController.text : '';
    primaryMobNocommunicationController.text =
        shouldCopy == true ? primaryMobNoController.text : '';
    alternativeCountryCodecommunicationController.text =
        shouldCopy == true ? alternativeCountryCodeController.text : '';
    alternativeMobNocommunicationController.text =
        shouldCopy == true ? alternativeMobNoController.text : '';
    primaryEmailcommunicationController.text =
        shouldCopy == true ? primaryEmailController.text : '';
    primaryAlternateEmailcommunicationController.text =
        shouldCopy == true ? primaryAlternateEmailController.text : '';
  }

  Future<void> _setIntialState(FindOneEntity state) async {
    landlineNoController.text = state.primaryLandline ?? '';
    primaryMobNoController.text = state.primaryMobile ?? '';
    alternativeMobNoController.text = state.alternateMobile ?? '';
    primaryEmailController.text = state.primaryEmail ?? '';
    primaryAlternateEmailController.text = state.alternateEmail ?? '';

    landlineNocommunicationController.text =
        state.communicationPrimaryLandline ?? '';
    primaryMobNocommunicationController.text =
        state.communicationPrimaryMobile ?? '';
    alternativeMobNocommunicationController.text =
        state.communicationAlternateMobile ?? '';
    primaryEmailcommunicationController.text =
        state.communicationPrimaryEmail ?? '';
    primaryAlternateEmailcommunicationController.text =
        state.alternateEmail ?? '';
  }

  void _showSnackSuccess(BuildContext context) {
    CustomSnackBar.show(
      context,
      message: "Contact Details Uploaded Successful",
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
