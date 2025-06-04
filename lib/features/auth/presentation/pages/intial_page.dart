import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:maxwealth_distributor_app/common/formatters.dart';
import 'package:maxwealth_distributor_app/common/validator.dart';
import 'package:maxwealth_distributor_app/config/routes/app_router.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/auth_user/auth_user_cubit.dart';
import 'package:maxwealth_distributor_app/gen/assets.gen.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'package:maxwealth_distributor_app/widgets/custom_keypad.dart';
import 'package:maxwealth_distributor_app/widgets/custom_mpin_widget.dart';

import '../../../../core/utils/auth_biometric.dart';

@RoutePage()
class IntialPage extends StatefulWidget {
  const IntialPage({super.key});

  @override
  State<IntialPage> createState() => _IntialPageState();
}

class _IntialPageState extends State<IntialPage> {
  final TextEditingController _mpinController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState() {
    context.read<AuthUserCubit>().authenticateUser();

    super.initState();
  }

  void _navigateToDashboard() {
    context.replaceRoute(const DashboardRoute());
  }

  Widget _buildMpinScreen(String fullName) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: Image.asset(Assets.images.mpinLogo.path),
              ),
              const SizedBox(height: 24),
              Text(
                "Hi, ${Formatters().capitalizeWords(fullName)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter your PIN",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              const SizedBox(height: 30),
              CustomMpinWidget(
                controller: _mpinController,
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () async {
                  AuthBiometric().authenticateWithBiometrics(context);
                },
                child: const Text(
                  "Use fingerprint",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomKeypad(
                controller: _mpinController,
                onCompleted: Validators.validateMpin,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthUserCubit, AuthUserState>(
      listener: (context, state) {
        if (state is AuthUserFailureState) {
          context.replaceRoute(const LoginRoute());
        }
      },
      builder: (context, state) {
        if (state is AuthUserLoadingState) {
          return const Scaffold(
            backgroundColor: AppColors.pureWhite,
            body: Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            )),
          );
        }
        if (state is AuthUserSuccessState) {
          AuthBiometric().authenticateWithBiometrics(context);
          return _buildMpinScreen(state.authUserEntity.fullName);
        }
        return const SizedBox();
      },
    );
  }
}
