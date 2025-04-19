import 'package:auto_route/auto_route.dart';

import '../auth/pages/enter_password.dart';
import '../auth/pages/forgot_password.dart';
import '../auth/pages/signin.dart';
import '../auth/pages/signup.dart';
import '../splash/splash/splash.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(
          page: SignUpRoute.page,
        ),
        AutoRoute(
          page: EnterPassWordRoute.page,
        ),
        AutoRoute(
          page: ForgotPasswordRoute.page,
        ),
        AutoRoute(
          page: SigninRoute.page,
        ),
      ];
}
