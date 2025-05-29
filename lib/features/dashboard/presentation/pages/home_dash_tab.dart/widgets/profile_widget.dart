import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../../../../../../common/formatters.dart';
import '../../../../../auth/presentation/bloc/auth_user/auth_user_cubit.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthUserCubit, AuthUserState>(
      builder: (context, state) {
        if (state is AuthUserSuccessState) {
          return Row(
            children: [
              _profileWidget(context, "${state.authUserEntity.fullName}"),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _userNameText(context, state.authUserEntity.fullName),
                  _adminText(context, state.authUserEntity.role)
                ],
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _profileWidget(BuildContext context, String name) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.primaryColor,
      child: Text(
        Formatters().getInitials(name),
        style: const TextStyle(
          color: AppColors.pureWhite,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _userNameText(BuildContext context, String name) {
    return Text(
      name,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _adminText(BuildContext context, String role) {
    return Text(
      role,
      style: const TextStyle(fontSize: 12, color: Colors.grey),
    );
  }
}
