import 'package:auto_route/auto_route.dart';
import 'package:clot_store/gen/assets.gen.dart';
import 'package:clot_store/presentation/router/app_router.dart';
import 'package:clot_store/presentation/splash/bloc/splash_state.dart';
import 'package:clot_store/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UnAuthorized) {
          context.pushRoute(const SigninRoute());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
            child: SvgPicture.asset(
          Assets.appIcons.clotStoreSplashLogo.path,
        )),
      ),
    );
  }
}
