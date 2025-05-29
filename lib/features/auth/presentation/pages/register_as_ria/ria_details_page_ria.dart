import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/validator.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/find_one/find_one_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/pass_id_pagetopage/pass_id_pagetopage_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/ria_flow_check/ria_flow_check_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/ria_patch/ria_patch_cubit.dart';
import 'package:maxwealth_distributor_app/widgets/custom_date_picker.dart';
import 'package:maxwealth_distributor_app/widgets/custom_loading_widget.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../../widgets/submit_button_widget.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../../domain/entities/find_one_entity.dart';
import '../../bloc/mfd_flow_check/mfd_flow_check_cubit.dart';

class RiaDetailsPageRia extends StatefulWidget {
  final PageController? pageController;

  const RiaDetailsPageRia({super.key, this.pageController});

  @override
  State<RiaDetailsPageRia> createState() => _RiaDetailsPageRiaState();
}

class _RiaDetailsPageRiaState extends State<RiaDetailsPageRia> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController rIAController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController entityController = TextEditingController();
  final TextEditingController entityShortController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController tanController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _rIACode(context),
                        const SizedBox(height: 15),
                        _panCard(context),
                        const SizedBox(height: 15),
                        _entityName(context),
                        const SizedBox(height: 15),
                        _entityShortName(context),
                        const SizedBox(height: 15),
                        _websiteText(context),
                        const SizedBox(height: 15),
                        _arnValidToDate(context),
                        const SizedBox(height: 15),
                        _tanTextField(context),
                        const SizedBox(height: 15),
                        BlocConsumer<RiaPatchCubit, RiaPatchState>(
                          listener: (context, state) {
                            if (state is RiaPatchSuccessState) {
                              widget.pageController!.jumpToPage(2);
                              context
                                  .read<RiaFlowCheckCubit>()
                                  .setRIARegistrationFlowCheck(1);
                              _showSnackSuccess(context);
                            }
                            if (state is RiaPatchFailureState) {
                              _showSnackFailure(
                                  context, state.errorMessage.toString());
                            }
                          },
                          builder: (context, state) {
                            if (state is RiaPatchLoadingState) {
                              return const CustomLoadingButton(
                                  color: AppColors.primaryColor);
                            }
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SubmitButtonWidget(
                                          label: "Next Step",
                                          onPressed: () {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              final id = context
                                                  .read<PassIdPagetopageCubit>()
                                                  .getId;
                                              context
                                                  .read<RiaPatchCubit>()
                                                  .patchRIA(
                                                      id: id.toString(),
                                                      riaCode:
                                                          rIAController.text,
                                                      equityName:
                                                          entityController.text,
                                                      equityShortCode:
                                                          entityShortController
                                                              .text,
                                                      pan: panController.text,
                                                      sipDemat: false,
                                                      tanCode:
                                                          tanController.text,
                                                      website: websiteController
                                                          .text);
                                            }
                                          },
                                          color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )),
            );
          },
        );
      },
    );
  }

  Widget _rIACode(BuildContext context) {
    return TextFieldWidget(
      onSaved: (newValue) {},
      labelText: "RIA Code",
      hintText: "Enter the RIA Code",
      controller: rIAController,
      textCapitalization: TextCapitalization.characters,
      isNumberOrString: TextInputType.text,
      onChanged: (value) {},
      textInputFormat: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
      ],
      validator: Validators.validateRia,
    );
  }

  Widget _panCard(BuildContext context) {
    return TextFieldWidget(
      labelText: "PAN",
      hintText: "Enter the PAN",
      controller: panController,
      isNumberOrString: TextInputType.text,
      textCapitalization: TextCapitalization.characters,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^[A-Z]{0,5}[0-9]{0,4}[A-Z]{0,1}$')),
      ],
      validator: Validators.validatePanNumber,
    );
  }

  Widget _entityName(BuildContext context) {
    return TextFieldWidget(
      labelText: "Entity Name",
      hintText: "Enter the entity name",
      controller: entityController,
      isNumberOrString: TextInputType.text,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9\s&.,'-]")),
      ],
      validator: Validators.validateEntityName,
    );
  }

  Widget _entityShortName(BuildContext context) {
    return TextFieldWidget(
      labelText: "Entity Short Name",
      hintText: "Enter the entity short name",
      controller: entityShortController,
      isNumberOrString: TextInputType.text,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9\s&.,'-]")),
      ],
      validator: Validators.validateEntityName,
    );
  }

  Widget _websiteText(BuildContext context) {
    return TextFieldWidget(
      labelText: "Website",
      hintText: "Enter the website url",
      controller: websiteController,
      isNumberOrString: TextInputType.text,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(
          RegExp(r"[A-Za-z0-9:/?&.=_%\-]"),
        ),
      ],
      validator: Validators.validateWebsite,
    );
  }

  Widget _arnValidToDate(BuildContext context) {
    return CustomDatePicker(
      labelText: "ARN Valid to date",
      hintText: "dd-mm-yyyy",
      onDatePicked: (p0) {
        toDateController.text = p0.toString();
      },
    );
  }

  Widget _tanTextField(BuildContext context) {
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

  Future<void> _setInitialData(FindOneEntity data) async {
    rIAController.text = data.riaCode ?? '';
    panController.text = data.pan ?? '';
    tanController.text = data.tanCode ?? '';
    entityController.text = data.equityName ?? '';
    entityShortController.text = data.equityShortName ?? '';
    websiteController.text = data.website ?? '';
    toDateController.text = data.arnEndDate ?? '';
  }

  void _showSnackSuccess(BuildContext context) {
    CustomSnackBar.show(
      context,
      message: "Ria Details Uploaded Successful",
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
