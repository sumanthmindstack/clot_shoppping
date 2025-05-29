import 'package:alice/alice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/euin/euin_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/find_one/find_one_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/generate_otp/generate_otp_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/get_euin_details/get_euin_details_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/mfd_flow_check/mfd_flow_check_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/mfd_patch_address_details/mfd_patch_address_details_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'config/routes/app_router.dart';
import 'features/auth/presentation/bloc/address_corres_detail_selected/address_corres_detail_selected_cubit.dart';
import 'features/auth/presentation/bloc/auth_user/auth_user_cubit.dart';
import 'features/auth/presentation/bloc/contact_details/contact_details_cubit.dart';
import 'features/auth/presentation/bloc/mfd/mfd_cubit.dart';
import 'features/auth/presentation/bloc/mfd_patch/mfd_patch_cubit.dart';
import 'features/auth/presentation/bloc/pass_id_pagetopage/pass_id_pagetopage_cubit.dart';
import 'features/auth/presentation/bloc/registration_flow/registration_flow_cubit.dart';
import 'features/auth/presentation/bloc/ria/ria_cubit.dart';
import 'features/auth/presentation/bloc/ria_bank/ria_bank_cubit.dart';
import 'features/auth/presentation/bloc/ria_contact_details/ria_contact_details_cubit.dart';
import 'features/auth/presentation/bloc/ria_flow_check/ria_flow_check_cubit.dart';
import 'features/auth/presentation/bloc/ria_patch/ria_patch_cubit.dart';
import 'features/auth/presentation/bloc/verify_otp/verify_otp_cubit.dart';
import 'features/dashboard/presentation/bloc/dash_monthwise_invester_details_graph/dash_monthwise_invester_details_graph_cubit.dart';
import 'features/dashboard/presentation/bloc/dash_monthwise_sip_details_graph/dash_monthwise_sip_details_graph_cubit.dart';
import 'features/dashboard/presentation/bloc/dash_monthwise_trans_details_graph/dash_monthwise_trans_details_graph_cubit.dart';
import 'features/dashboard/presentation/bloc/dash_monthwise_user_details_graph/dash_monthwise_user_details_graph_cubit.dart';
import 'features/dashboard/presentation/bloc/dashboard_data_count/dashboard_data_count_cubit.dart';
import 'features/dashboard/presentation/bloc/selected_type/selected_type_cubit.dart';
import 'features/dashboard/presentation/bloc/trans_typewise_returns/trans_typewise_returns_cubit.dart';
import 'get_it/get_it.dart';

class MaxWealthDistributor extends StatefulWidget {
  const MaxWealthDistributor({super.key});

  @override
  State<MaxWealthDistributor> createState() => _MaxWealthDistributorState();
}

class _MaxWealthDistributorState extends State<MaxWealthDistributor> {
  final _appRouter = AppRouter();
  late final Alice alice;
  @override
  void initState() {
    alice = Alice(
      showNotification: true,
      showInspectorOnShake: true,
      navigatorKey: _appRouter.navigatorKey,
      showShareButton: true,
    );
    getIt<Dio>().interceptors.add(
          alice.getDioInterceptor(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<GenerateOtpCubit>()),
        BlocProvider(create: (context) => getIt<RegistrationFlowCubit>()),
        BlocProvider(create: (context) => getIt<VerifyOtpCubit>()),
        BlocProvider(create: (context) => getIt<RegisterUserCubit>()),
        BlocProvider(create: (context) => getIt<MfdFlowCheckCubit>()),
        BlocProvider(create: (context) => getIt<RiaFlowCheckCubit>()),
        BlocProvider(create: (context) => getIt<ReGenerateOtpCubit>()),
        BlocProvider(create: (context) => getIt<MfdCubit>()),
        BlocProvider(create: (context) => getIt<FindOneCubit>()),
        BlocProvider(create: (context) => getIt<PassIdPagetopageCubit>()),
        BlocProvider(create: (context) => getIt<MfdPatchCubit>()),
        BlocProvider(create: (context) => getIt<GetEuinDetailsCubit>()),
        BlocProvider(create: (context) => getIt<EuinCubit>()),
        BlocProvider(create: (context) => getIt<MfdPatchAddressDetailsCubit>()),
        BlocProvider(create: (context) => getIt<ContactDetailsCubit>()),
        BlocProvider(
            create: (context) => getIt<AddressCorresDetailSelectedCubit>()),
        BlocProvider(create: (context) => getIt<RiaCubit>()),
        BlocProvider(create: (context) => getIt<RiaPatchCubit>()),
        BlocProvider(create: (context) => getIt<RiaContactDetailsCubit>()),
        BlocProvider(create: (context) => getIt<RiaBankCubit>()),
        BlocProvider(create: (context) => getIt<AuthUserCubit>()),
        BlocProvider(create: (context) => getIt<DashboardDataCountCubit>()),
        BlocProvider(
            create: (context) => getIt<DashMonthwiseUserDetailsGraphCubit>()),
        BlocProvider(
            create: (context) => getIt<DashMonthwiseTransDetailsGraphCubit>()),
        BlocProvider(create: (context) => getIt<TransTypewiseReturnsCubit>()),
        BlocProvider(
            create: (context) => getIt<DashMonthwiseSipDetailsGraphCubit>()),
        BlocProvider(
            create: (context) =>
                getIt<DashMonthwiseInvesterDetailsGraphCubit>()),
        BlocProvider(create: (context) => getIt<SelectedTypeCubit>()),
      ],
      child: MaterialApp(
          title: "Maxwealth Distributor",
          home: Scaffold(
            body: MaterialApp.router(
              debugShowCheckedModeBanner: true,
              themeMode: ThemeMode.light,
              routerConfig: _appRouter.config(
                navigatorObservers: () => [
                  AutoRouteObserver(),
                ],
              ),
            ),
          )),
    );
  }
}
