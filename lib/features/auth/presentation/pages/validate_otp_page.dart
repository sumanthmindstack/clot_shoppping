import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/validator.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/verify_otp/verify_otp_cubit.dart';
import 'package:maxwealth_distributor_app/widgets/app_bar_widget.dart';
import 'package:maxwealth_distributor_app/widgets/custom_rich_text_field.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/animate_page_widget.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../../widgets/custom_pinput.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/submit_button_widget.dart';
import '../bloc/generate_otp/generate_otp_cubit.dart';

@RoutePage()
class ValidateOtpPage extends StatefulWidget {
  final String mobileNumber;
  const ValidateOtpPage({super.key, required this.mobileNumber});

  @override
  State<ValidateOtpPage> createState() => _ValidateOtpPageState();
}

class _ValidateOtpPageState extends State<ValidateOtpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatePageWidget(
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(automaticallyImplyLeading: true),
              Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _welcomeText(context),
                        const SizedBox(height: 20),
                        _loginText(context),
                        const SizedBox(height: 20),
                        _otpText(context),
                        const SizedBox(height: 10),
                        _pinputField(context),
                        const SizedBox(height: 10),
                        _recendOTpText(context),
                        const SizedBox(height: 30),
                        BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
                          listener: (context, state) {
                            if (state is VerifyOtpSuccessState) {
                              _showSnackSuccess(context);
                            } else if (state is VerifyOtpFailureState) {
                              _showSnackFailure(
                                  context, state.errorMessage.toString());
                            }
                          },
                          builder: (context, state) {
                            if (state is VerifyOtpLoadingState) {
                              return const CustomLoadingButton(
                                  color: AppColors.primaryColor);
                            }
                            return SubmitButtonWidget(
                              label: "Submit",
                              onPressed: () {
                                _onSubmit();
                              },
                              color: AppColors.primaryColor,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _welcomeText(BuildContext context) {
    return const Text("WELCOME BACK", style: TextStyle(fontSize: 18));
  }

  Widget _loginText(BuildContext context) {
    return const Text("Log In to your Account",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }

  Widget _otpText(BuildContext context) {
    return const Text("OTP",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal));
  }

  Widget _recendOTpText(BuildContext context) {
    return BlocConsumer<ReGenerateOtpCubit, ReGenerateOtpState>(
      listener: (context, state) {
        if (state is ReGenertateOtpSuccessState) {
          CustomSnackBar.show(context,
              message: "Otp Resent!",
              backgroundColor: AppColors.primaryColor,
              borderRadius: 16);
        }
      },
      builder: (context, state) {
        return CustomRichTextField(
          normalText: "Didn't receive OTP? ",
          highlightedText: "Resend OTP",
          onTap: () {
            context
                .read<ReGenerateOtpCubit>()
                .reGenerateOtp(widget.mobileNumber);
          },
        );
      },
    );
  }

  Widget _pinputField(BuildContext context) {
    return CustomPinput(
      validateOtp: Validators.validateOtp,
      controller: _pinController,
      length: 4,
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<VerifyOtpCubit>().verifyOTP(
          mobileNumber: widget.mobileNumber, otp: _pinController.text);
    }
  }

  void _showSnackSuccess(BuildContext context) {
    AutoRouter.of(context).replaceAll([const DashboardRoute()]);
    CustomSnackBar.show(
      context,
      message: "OTP Verified Successful",
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
