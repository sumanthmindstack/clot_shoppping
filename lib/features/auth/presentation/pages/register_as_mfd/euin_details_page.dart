import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/validator.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/params/euin_params.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/euin/euin_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/get_euin_details/get_euin_details_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/pass_id_pagetopage/pass_id_pagetopage_cubit.dart';
import 'package:maxwealth_distributor_app/widgets/custom_date_picker.dart';
import 'package:maxwealth_distributor_app/widgets/custom_snackbar.dart';
import 'package:maxwealth_distributor_app/widgets/custom_text_button.dart';
import 'package:maxwealth_distributor_app/widgets/text_field_widget.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../widgets/custom_loading_widget.dart';
import '../../../../../widgets/submit_button_widget.dart';
import '../../../domain/entities/get_euin_details_entity.dart';
import '../../bloc/mfd_flow_check/mfd_flow_check_cubit.dart';

class EuinDetailsPage extends StatefulWidget {
  final PageController? pageController;

  const EuinDetailsPage({super.key, this.pageController});

  @override
  State<EuinDetailsPage> createState() => _EuinDetailsPageState();
}

class _EuinDetailsPageState extends State<EuinDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _euinCodeControllers = [];
  final List<DateTime?> _fromDates = [];
  final List<DateTime?> _toDates = [];
  final ScrollController _scrollController = ScrollController();
  final List<EuinDetails> euinDetailsList = [];

  @override
  void initState() {
    final userId = context.read<PassIdPagetopageCubit>().getUserId;
    context
        .read<GetEuinDetailsCubit>()
        .getEuinDetails(userId: userId.toString());
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _euinCodeControllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetEuinDetailsCubit, GetEuinDetailsState>(
      listener: (context, state) {
        if (state is GetEuinDetailsSuccessState) {
          _setInitialData(state.euinDetailsEntity!.euin!);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 20),
                      _addEuinCode(context),
                      const SizedBox(height: 15),
                      _addedNewRows(context),
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SubmitButtonWidget(
                                  label: "Prev",
                                  onPressed: () {
                                    widget.pageController!.jumpToPage(1);
                                    context
                                        .read<MfdFlowCheckCubit>()
                                        .setMFDRegistrationFlowCheck(0);
                                  },
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: BlocConsumer<EuinCubit, EuinState>(
                                  listener: (context, state) {
                                    if (state is EuinSuccessState) {
                                      _showSnackSuccess(context);
                                      widget.pageController!.jumpToPage(3);
                                      context
                                          .read<MfdFlowCheckCubit>()
                                          .setMFDRegistrationFlowCheck(2);
                                    } else if (state is EuinFailureState) {
                                      _showSnackFailure(context,
                                          state.errorMessage.toString());
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is EuinLoadingState) {
                                      return const CustomLoadingButton(
                                          color: AppColors.primaryColor);
                                    }
                                    return SubmitButtonWidget(
                                      label: "Next Step",
                                      onPressed: () {
                                        final userId = context
                                            .read<PassIdPagetopageCubit>()
                                            .getUserId;
                                        final id = context
                                            .read<PassIdPagetopageCubit>()
                                            .getId;

                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          final euinDetailsList =
                                              _euinCodeControllers
                                                  .asMap()
                                                  .entries
                                                  .map((entry) => EuinDetails(
                                                      euinCode:
                                                          entry.value.text,
                                                      euinFrom:
                                                          _fromDates[entry.key]
                                                              .toString(),
                                                      euinTo:
                                                          _toDates[entry.key]
                                                              .toString()))
                                                  .toList();

                                          context.read<EuinCubit>().euin(
                                              userId: userId.toString(),
                                              mfdId: id,
                                              euinDetails: euinDetailsList);
                                        }
                                      },
                                      color: AppColors.primaryColor,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _addEuinCode(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTextButton(
          text: "Add",
          backgroundColor: AppColors.borderGrey,
          onTap: _addEntry,
          textColor: AppColors.primaryColor,
        ),
        const SizedBox(
          width: 5,
        ),
        CustomTextButton(
          text: "Clear",
          backgroundColor: AppColors.borderGrey,
          onTap: () {
            setState(() {
              _euinCodeControllers.clear();
              _toDates.clear();
              _fromDates.clear();
            });
          },
          textColor: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _addedNewRows(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _euinCodeControllers.length,
      itemBuilder: (context, index) {
        return Card(
          color: AppColors.backgroundGrey,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      text: "Delete",
                      backgroundColor: AppColors.borderGrey,
                      onTap: () {
                        setState(() {
                          _euinCodeControllers.removeAt(index);
                          _fromDates.removeAt(index);
                          _toDates.removeAt(index);
                        });
                      },
                      textColor: AppColors.primaryColor,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                _euinCode(context, index),
                const SizedBox(height: 10),
                _euinFromDateText(context, index),
                const SizedBox(height: 10),
                _euinToDateText(context, index),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _euinCode(BuildContext context, int index) {
    return TextFieldWidget(
      labelText: "EUIN Code",
      validator: Validators.validateEuinCode,
      isNumberOrString: TextInputType.name,
      textCapitalization: TextCapitalization.characters,
      onChanged: (value) {},
      textInputFormat: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]+')),
      ],
      controller: _euinCodeControllers[index],
    );
  }

  Widget _euinFromDateText(BuildContext context, int index) {
    return CustomDatePicker(
      labelText: "From Date",
      hintText: "dd-mm-yyyy",
      initialDate: _fromDates[index],
      onDatePicked: (date) {
        setState(() {
          _fromDates[index] = date;
        });
      },
    );
  }

  Widget _euinToDateText(BuildContext context, int index) {
    return CustomDatePicker(
      labelText: "To Date",
      hintText: "dd-mm-yyyy",
      initialDate: _toDates[index],
      onDatePicked: (date) {
        setState(() {
          _toDates[index] = date;
        });
      },
    );
  }

  void _addEntry() {
    setState(() {
      _euinCodeControllers.add(TextEditingController());
      if (_euinCodeControllers.length == 1) {
        _fromDates.add(DateTime.now());
        _toDates.add(DateTime.now());
      } else {
        _fromDates.add(null);
        _toDates.add(null);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _showSnackSuccess(BuildContext context) {
    CustomSnackBar.show(
      context,
      message: "EUIN Details Uploaded Successful",
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

  void _setInitialData(List<EuinDetailsEntity> euinDetails) {
    setState(() {
      _euinCodeControllers.clear();
      _fromDates.clear();
      _toDates.clear();

      if (euinDetails.isEmpty) {
        _addEntry();
      } else {
        for (var detail in euinDetails) {
          final codeController = TextEditingController(text: detail.euinCode);
          _euinCodeControllers.add(codeController);
          _fromDates.add(DateTime.tryParse(detail.euinFrom) ?? DateTime.now());
          _toDates.add(DateTime.tryParse(detail.euinTo) ?? DateTime.now());
        }
      }
    });
  }
}
