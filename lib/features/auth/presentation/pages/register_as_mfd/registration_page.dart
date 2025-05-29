import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maxwealth_distributor_app/common/validator.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/pass_id_pagetopage/pass_id_pagetopage_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'package:maxwealth_distributor_app/widgets/custom_image_picker.dart';
import 'package:maxwealth_distributor_app/widgets/submit_button_widget.dart';
import 'package:maxwealth_distributor_app/widgets/text_field_widget.dart';
import 'package:maxwealth_distributor_app/widgets/custom_dropdown_field.dart';
import '../../../../../widgets/custom_loading_widget.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../bloc/find_one/find_one_cubit.dart';
import '../../bloc/mfd/mfd_cubit.dart';
import '../../bloc/mfd_flow_check/mfd_flow_check_cubit.dart';
import '../../bloc/registration_flow/registration_flow_cubit.dart';
import '../../bloc/ria/ria_cubit.dart';
import '../../bloc/ria_flow_check/ria_flow_check_cubit.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  final String type;
  final PageController? pageController;
  const RegistrationScreen({
    super.key,
    required this.type,
    this.pageController,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isRobotChecked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? userType;
  String? type;
  XFile? file1;
  XFile? file2;
  final _formKey = GlobalKey<FormState>();
  bool? _isRiaImageSelected = false;
  bool? _isCorporateImageSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

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
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _registerAsField(context),
                  const SizedBox(height: 15),
                  _primaryEmailText(context),
                  const SizedBox(height: 15),
                  _typeTextField(context),
                  const SizedBox(height: 15),
                  _primaryMobileNumber(context),
                  const SizedBox(height: 15),
                  _getImage(context),
                  const SizedBox(height: 15),
                  _getCorporatecertificate(context),
                  const SizedBox(height: 15),
                  _iAmNotaRoboat(context),
                  const SizedBox(height: 15),
                  BlocListener<FindOneCubit, FindOneState>(
                    listener: (context, state) {
                      if (widget.type.contains("MFD")) {
                        widget.pageController!.jumpToPage(1);
                        context
                            .read<MfdFlowCheckCubit>()
                            .setMFDRegistrationFlowCheck(0);
                      } else {
                        widget.pageController!.jumpToPage(1);
                        context
                            .read<RiaFlowCheckCubit>()
                            .setRIARegistrationFlowCheck(0);
                      }
                    },
                    child: BlocConsumer<RiaCubit, RiaState>(
                      listener: (context, state) {
                        if (state is RiaSuccess) {
                          context.read<PassIdPagetopageCubit>().setIdhere(
                              state.mfdEntity.id!,
                              int.parse(state.mfdEntity.userId.toString()));
                          context
                              .read<RegistrationFlowCubit>()
                              .selectedMFD(false);
                          context
                              .read<RiaFlowCheckCubit>()
                              .setRIARegistrationFlowCheck(0);
                          widget.pageController!.jumpToPage(1);
                        }
                      },
                      builder: (context, state) {
                        return BlocListener<MfdCubit, MfdState>(
                          listener: (context, state) {
                            debugPrint("MfdCubit state: $state");
                            if (state is MfdSuccess) {
                              print("here in MFD success");

                              context.read<PassIdPagetopageCubit>().setIdhere(
                                  state.mfdEntity.id!,
                                  int.parse(state.mfdEntity.userId.toString()));
                              widget.pageController!.jumpTo(1);
                            }
                          },
                          child: BlocConsumer<RegisterUserCubit,
                              RegisterUserState>(
                            listener: (context, state) {
                              if (state is RegisterUserSuccessState) {
                                widget.type.contains("MFD")
                                    ? context.read<MfdCubit>().mfd(
                                          userId: state.registerUserEntity.id
                                              .toString(),
                                        )
                                    : context.read<RiaCubit>().ria(
                                          userId: state.registerUserEntity.id
                                              .toString(),
                                        );
                                _showSnackSuccess(context,
                                    state.registerUserEntity.id.toString());
                              } else if (state is RegisterUserFailureState) {
                                _showSnackFailure(
                                    context, state.errorMessage.toString());
                              }
                            },
                            builder: (context, state) {
                              if (state is RegisterUserLoadingState) {
                                return const CustomLoadingButton(
                                    color: AppColors.primaryColor);
                              }
                              return SubmitButtonWidget(
                                label: "Next Step",
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context
                                        .read<RegisterUserCubit>()
                                        .registerUser(
                                          userType: userType,
                                          email: emailController.text,
                                          type: type,
                                          mobileNumber: phoneController.text,
                                          file1: File(file1!.path),
                                          file2: File(file2!.path),
                                        );
                                  }
                                },
                                color: AppColors.primaryColor,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerAsField(BuildContext context) {
    return CustomDropdownField(
      onSelectionChanged: (value) {
        if (value.containsValue("RIA")) {
          userType = "RIA";
          context.read<RegistrationFlowCubit>().selectedMFD(false);
        } else {
          userType = "MFD";
          context.read<RegistrationFlowCubit>().selectedMFD(true);
        }
      },
      dropdowns: [
        DropdownConfig("Registered as", ["MFD", "RIA"]),
      ],
    );
  }

  Widget _primaryEmailText(BuildContext context) {
    return TextFieldWidget(
      controller: emailController,
      textInputFormat: [FilteringTextInputFormatter.singleLineFormatter],
      onChanged: (value) {},
      isNumberOrString: TextInputType.emailAddress,
      hintText: "Enter the email",
      labelText: "Primary E-mail",
      validator: Validators.validateEmail,
      onSaved: (newValue) {},
    );
  }

  Widget _typeTextField(BuildContext context) {
    return CustomDropdownField(
      onSelectionChanged: (value) {
        if (value.containsValue("Corporate")) {
          type = "Corporate";
        } else {
          type = "Individual";
        }
      },
      dropdowns: [
        DropdownConfig("Type", ["Corporate", "Individual"]),
      ],
    );
  }

  Widget _primaryMobileNumber(BuildContext context) {
    return TextFieldWidget(
      controller: phoneController,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.singleLineFormatter,
        LengthLimitingTextInputFormatter(10),
      ],
      isNumberOrString: TextInputType.phone,
      hintText: "Enter the mobile no",
      labelText: "Primary mobile no",
      validator: Validators.validateMobileNumber,
      onSaved: (newValue) {},
    );
  }

  Widget _getImage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormField<XFile>(
          validator: (file) {
            if (file == null) {
              return 'Please pick a file';
            }
            return null;
          },
          builder: (FormFieldState<XFile> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilePickerWidget(
                  onFilePicked: (XFile? file) {
                    file1 = file;
                    state.didChange(file);
                    if (file != null) _isRiaImageSelected = true;
                  },
                  labelText: 'Ria/mfd certificate',
                  hintText: 'No File chosen',
                ),
                if (state.hasError && _isRiaImageSelected == false)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        )
      ],
    );
  }

  Widget _getCorporatecertificate(BuildContext context) {
    return FormField<XFile>(
      validator: (file) {
        if (file == null) {
          return 'Please pick a file';
        }
        return null;
      },
      builder: (FormFieldState<XFile> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilePickerWidget(
              onFilePicked: (XFile? file) {
                file2 = file;
                state.didChange(file);
                if (file != null) _isCorporateImageSelected = true;
              },
              labelText: 'Corporate certificate',
              hintText: 'No File chosen',
            ),
            if (state.hasError && _isCorporateImageSelected == false)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _iAmNotaRoboat(BuildContext context) {
    return FormField<bool>(
      initialValue: isRobotChecked,
      validator: (value) {
        if (value != true) {
          return 'Please confirm you are not a robot';
        }
        return null;
      },
      builder: (FormFieldState<bool> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        fillColor: WidgetStatePropertyAll(!isRobotChecked
                            ? AppColors.backgroundGrey
                            : AppColors.primaryColor),
                        value: isRobotChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isRobotChecked = value ?? false;
                            state.didChange(value);
                          });
                        },
                      ),
                      const Text(
                        "I am not a robot",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            if (state.hasError && !isRobotChecked)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showSnackSuccess(BuildContext context, String userId) {
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
