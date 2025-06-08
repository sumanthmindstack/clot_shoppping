import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/pages/validate_otp_page.dart';
import 'package:maxwealth_distributor_app/features/walkthrough/walkthrough.dart';
import '../../features/auth/presentation/pages/account_is_under_review.dart';
import '../../features/auth/presentation/pages/distributor_agreement_page.dart';
import '../../features/auth/presentation/pages/intial_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_as_mfd/registration_page.dart';
import '../../features/auth/presentation/pages/registration_process_step_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/investers/domain/entity/get_invester_list_entitty.dart';
import '../../features/investers/presentation/pages/widgets/add_new_bank_page.dart';
import '../../features/investers/presentation/pages/widgets/add_new_mandate_page.dart';
import '../../features/investers/presentation/pages/widgets/invester_profile_widget.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: Walkthrough1Route.page),
        AutoRoute(page: IntialRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegistrationRoute.page),
        AutoRoute(page: RegistrationProcessStepRoute.page),
        AutoRoute(page: UnderReviewRoute.page),
        AutoRoute(page: ValidateOtpRoute.page),
        AutoRoute(page: DistributorAgreementRoute.page),
        AutoRoute(page: DashboardRoute.page, maintainState: true),
        AutoRoute(page: InvestorProfileRoute.page),
        AutoRoute(page: AddNewBankRoute.page),
        AutoRoute(page: AddNewMandateRoute.page),
      ];
}
