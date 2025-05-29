import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/formatters.dart';
import 'package:maxwealth_distributor_app/common/validator.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/mfd_patch/mfd_patch_cubit.dart';
import 'package:maxwealth_distributor_app/widgets/text_field_widget.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../widgets/custom_date_picker.dart';
import '../../../../../widgets/custom_loading_widget.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../../widgets/submit_button_widget.dart';
import '../../../domain/entities/find_one_entity.dart';
import '../../bloc/find_one/find_one_cubit.dart';
import '../../bloc/mfd_flow_check/mfd_flow_check_cubit.dart';
import '../../bloc/pass_id_pagetopage/pass_id_pagetopage_cubit.dart';

class ArnDetailsPage extends StatefulWidget {
  final PageController? pageController;
  const ArnDetailsPage({super.key, this.pageController});

  @override
  State<ArnDetailsPage> createState() => _ArnDetailsPageState();
}

class _ArnDetailsPageState extends State<ArnDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _arnCodeController = TextEditingController();
  final TextEditingController panCardController = TextEditingController();
  final TextEditingController tanController = TextEditingController();
  final TextEditingController arnDateValideToController =
      TextEditingController();
  final TextEditingController entityNameController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController arnDateValidFromController =
      TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
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
          _setInitialData(state.findOneEntity);
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
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _arnCodeText(context),
                      const SizedBox(height: 15),
                      _pandCardText(context),
                      const SizedBox(height: 15),
                      tanTextField(context),
                      const SizedBox(height: 15),
                      arnDateValidTo(context),
                      const SizedBox(height: 15),
                      entityNameTextField(context),
                      const SizedBox(height: 15),
                      websiteTextField(context),
                      const SizedBox(height: 15),
                      arnDateValidFrom(context),
                      const SizedBox(height: 15),
                      BlocConsumer<MfdPatchCubit, MfdPatchState>(
                        listener: (context, state) {
                          if (state is MfdPatchSuccessState) {
                            _showSnackSuccess(context);
                          }
                          if (state is MfdPatchFailureState) {
                            _showSnackFailure(
                                context, state.errorMessage.toString());
                          }
                        },
                        builder: (context, state) {
                          return BlocConsumer<MfdPatchCubit, MfdPatchState>(
                            listener: (context, state) {
                              if (state is MfdPatchSuccessState) {
                                _showSnackSuccess(context);
                                context.read<PassIdPagetopageCubit>().setIdhere(
                                    state.mfdPatchEntity.id,
                                    state.mfdPatchEntity.userId);
                              } else if (state is MfdPatchFailureState) {
                                _showSnackFailure(
                                    context, state.errorMessage.toString());
                                CustomSnackBar.show(context,
                                    message: state.errorMessage.toString());
                              }
                            },
                            builder: (context, state) {
                              if (state is MfdPatchLoadingState) {
                                return const CustomLoadingButton(
                                    color: AppColors.primaryColor);
                              }
                              return Column(
                                children: [
                                  SubmitButtonWidget(
                                    label: "Next Step",
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        final id = context
                                            .read<PassIdPagetopageCubit>()
                                            .getId;
                                        context.read<MfdPatchCubit>().patchMFD(
                                              id: id.toString(),
                                              arnCode: _arnCodeController.text,
                                              arnStartDate:
                                                  fromDateController.text,
                                              arnEndDate: toDateController.text,
                                              equityName:
                                                  entityNameController.text,
                                              pan: panCardController.text,
                                              sipDemat: true,
                                              tanCode: tanController.text,
                                              website: websiteController.text,
                                            );
                                      }
                                    },
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        );
      },
    );
  }

  Widget _arnCodeText(BuildContext context) {
    return TextFieldWidget(
        labelText: "ARN Code",
        hintText: "Enter the ARN Code",
        validator: Validators.validateArn,
        isNumberOrString: TextInputType.number,
        onChanged: (value) {},
        textInputFormat: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        controller: _arnCodeController);
  }

  Widget _pandCardText(BuildContext context) {
    return TextFieldWidget(
        labelText: "PAN",
        hintText: "Enter the PAN",
        textCapitalization: TextCapitalization.characters,
        validator: Validators.validatePanNumber,
        isNumberOrString: TextInputType.multiline,
        onChanged: (value) {},
        textInputFormat: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[A-Z\d]'),
          ),
          LengthLimitingTextInputFormatter(10),
        ],
        controller: panCardController);
  }

  Widget tanTextField(BuildContext context) {
    return TextFieldWidget(
        labelText: "TAN",
        hintText: "Enter the TAN",
        textCapitalization: TextCapitalization.characters,
        validator: Validators.validateTanNumber,
        isNumberOrString: TextInputType.multiline,
        onChanged: (value) {},
        textInputFormat: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[A-Z0-9]'),
          ),
          LengthLimitingTextInputFormatter(10),
        ],
        controller: tanController);
  }

  Widget arnDateValidTo(BuildContext context) {
    return CustomDatePicker(
      hintText: "dd-mm-yyyy",
      labelText: "ARN Valid To Date",
      onDatePicked: (p0) {
        toDateController.text = Formatters().formatDate(p0);
      },
    );
  }

  Widget entityNameTextField(BuildContext context) {
    return TextFieldWidget(
        labelText: "Entity Name",
        hintText: "Enter the Entity Name",
        validator: Validators.validateEntityName,
        textCapitalization: TextCapitalization.words,
        isNumberOrString: TextInputType.multiline,
        onChanged: (value) {},
        textInputFormat: [
          LengthLimitingTextInputFormatter(50),
          FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9\s\-_]+'),
          ),
        ],
        controller: entityNameController);
  }

  Widget websiteTextField(BuildContext context) {
    return TextFieldWidget(
        labelText: "Website",
        hintText: "Enter the Website",
        validator: Validators.validateWebsite,
        isNumberOrString: TextInputType.multiline,
        onChanged: (value) {},
        textInputFormat: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\-.:/]+')),
          TextInputFormatter.withFunction((oldValue, newValue) {
            return newValue.copyWith(
              text: newValue.text.toLowerCase(),
              selection: newValue.selection,
            );
          }),
        ],
        controller: websiteController);
  }

  Widget arnDateValidFrom(BuildContext context) {
    return CustomDatePicker(
      hintText: "dd-mm-yyyy",
      labelText: "ARN Valid From Date",
      onDatePicked: (p0) {
        fromDateController.text = Formatters().formatDate(p0);
      },
    );
  }

  Future<void> _setInitialData(FindOneEntity data) async {
    _arnCodeController.text = data.arnCode ?? '';
    panCardController.text = data.pan ?? '';
    tanController.text = data.tanCode ?? '';
    arnDateValideToController.text = data.arnEndDate ?? '';
    entityNameController.text = data.equityName ?? '';
    websiteController.text = data.website ?? '';
    arnDateValidFromController.text = data.arnStartDate ?? '';
    fromDateController.text = data.arnStartDate ?? '';
    toDateController.text = data.arnEndDate ?? '';
  }

  void _showSnackSuccess(BuildContext context) {
    widget.pageController!.jumpToPage(2);
    context.read<MfdFlowCheckCubit>().setMFDRegistrationFlowCheck(1);
    CustomSnackBar.show(
      context,
      message: "Register Details Uploaded Successful",
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
