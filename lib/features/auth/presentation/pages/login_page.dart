import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/config/routes/app_router.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/generate_otp/generate_otp_cubit.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'package:maxwealth_distributor_app/widgets/animate_page_widget.dart';
import 'package:maxwealth_distributor_app/widgets/submit_button_widget.dart';
import '../../../../common/validator.dart';
import '../../../../core/repository/token_repository.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/text_field_widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  String? _mobileNumber;
  TokenRepository? _tokenRepository;

  @override
  void initState() {
    // showWalkthroughPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatePageWidget(
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    _welcomeText(context),
                    const SizedBox(height: 10),
                    _loginText(context),
                    const SizedBox(height: 20),
                    _buildMobileInput(),
                    const SizedBox(height: 20),
                    _buildRegisterLink(context),
                    const SizedBox(height: 30),
                    BlocConsumer<GenerateOtpCubit, GenerateOtpState>(
                      listener: (context, state) {
                        if (state is GenertateOtpSuccessState) {
                          _showSnackSuccess(context);
                        }
                        if (state is GenertateOtpFailureState) {
                          _showSnackFailure(context, state.errorMessage!);
                        }
                      },
                      builder: (context, state) {
                        if (state is GenerateOtpLoadingState) {
                          return const CustomLoadingButton(
                              color: AppColors.primaryColor);
                        }
                        return SubmitButtonWidget(
                          label: "Generate OTP",
                          onPressed: _onSubmit,
                          color: AppColors.primaryColor,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
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

  Widget _buildMobileInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: 'Mobile ', style: TextStyle(color: Colors.black)),
              TextSpan(text: '*', style: TextStyle(color: AppColors.errorRed)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextFieldWidget(
          controller: phoneController,
          onChanged: (value) {},
          textInputFormat: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          isNumberOrString: TextInputType.phone,
          labelText: "Enter Mobile Number",
          validator: Validators.validateMobileNumber,
          onSaved: (val) => _mobileNumber = val,
        ),
      ],
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Don't have an account? ",
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: [
          TextSpan(
            text: 'Click here to register as a distributor',
            style: const TextStyle(color: AppColors.primaryColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  context.router.push(const RegistrationProcessStepRoute()),
          ),
        ],
      ),
    );
  }

  void showWalkthroughPage() {
    AutoRouter.of(context).push(const Walkthrough1Route());
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<GenerateOtpCubit>().generateOtp(_mobileNumber!);
    }
  }

  void _showSnackSuccess(BuildContext context) {
    CustomSnackBar.show(
      context,
      message: "OTP Sent!",
      backgroundColor: AppColors.primaryColor,
      borderRadius: 16,
    );
    context.pushRoute(ValidateOtpRoute(mobileNumber: _mobileNumber!));
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
