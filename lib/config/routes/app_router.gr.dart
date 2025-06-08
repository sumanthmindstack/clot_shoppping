// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddNewBankRoute.name: (routeData) {
      final args = routeData.argsAs<AddNewBankRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddNewBankPage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    AddNewMandateRoute.name: (routeData) {
      final args = routeData.argsAs<AddNewMandateRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddNewMandatePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardScreen(),
      );
    },
    DistributorAgreementRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DistributorAgreementPage(),
      );
    },
    IntialRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IntialPage(),
      );
    },
    InvestorProfileRoute.name: (routeData) {
      final args = routeData.argsAs<InvestorProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvestorProfilePage(
          key: args.key,
          userId: args.userId,
          index: args.index,
          bankId: args.bankId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    RegistrationProcessStepRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegistrationProcessStepPage(),
      );
    },
    RegistrationRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegistrationScreen(
          key: args.key,
          type: args.type,
          pageController: args.pageController,
        ),
      );
    },
    UnderReviewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UnderReviewScreen(),
      );
    },
    ValidateOtpRoute.name: (routeData) {
      final args = routeData.argsAs<ValidateOtpRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ValidateOtpPage(
          key: args.key,
          mobileNumber: args.mobileNumber,
        ),
      );
    },
    Walkthrough1Route.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Walkthrough1Page(),
      );
    },
  };
}

/// generated route for
/// [AddNewBankPage]
class AddNewBankRoute extends PageRouteInfo<AddNewBankRouteArgs> {
  AddNewBankRoute({
    Key? key,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
          AddNewBankRoute.name,
          args: AddNewBankRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewBankRoute';

  static const PageInfo<AddNewBankRouteArgs> page =
      PageInfo<AddNewBankRouteArgs>(name);
}

class AddNewBankRouteArgs {
  const AddNewBankRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final int userId;

  @override
  String toString() {
    return 'AddNewBankRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [AddNewMandatePage]
class AddNewMandateRoute extends PageRouteInfo<AddNewMandateRouteArgs> {
  AddNewMandateRoute({
    Key? key,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
          AddNewMandateRoute.name,
          args: AddNewMandateRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewMandateRoute';

  static const PageInfo<AddNewMandateRouteArgs> page =
      PageInfo<AddNewMandateRouteArgs>(name);
}

class AddNewMandateRouteArgs {
  const AddNewMandateRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final int userId;

  @override
  String toString() {
    return 'AddNewMandateRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [DashboardScreen]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DistributorAgreementPage]
class DistributorAgreementRoute extends PageRouteInfo<void> {
  const DistributorAgreementRoute({List<PageRouteInfo>? children})
      : super(
          DistributorAgreementRoute.name,
          initialChildren: children,
        );

  static const String name = 'DistributorAgreementRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IntialPage]
class IntialRoute extends PageRouteInfo<void> {
  const IntialRoute({List<PageRouteInfo>? children})
      : super(
          IntialRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntialRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InvestorProfilePage]
class InvestorProfileRoute extends PageRouteInfo<InvestorProfileRouteArgs> {
  InvestorProfileRoute({
    Key? key,
    required int userId,
    required int index,
    required List<BankDetailEntity> bankId,
    List<PageRouteInfo>? children,
  }) : super(
          InvestorProfileRoute.name,
          args: InvestorProfileRouteArgs(
            key: key,
            userId: userId,
            index: index,
            bankId: bankId,
          ),
          initialChildren: children,
        );

  static const String name = 'InvestorProfileRoute';

  static const PageInfo<InvestorProfileRouteArgs> page =
      PageInfo<InvestorProfileRouteArgs>(name);
}

class InvestorProfileRouteArgs {
  const InvestorProfileRouteArgs({
    this.key,
    required this.userId,
    required this.index,
    required this.bankId,
  });

  final Key? key;

  final int userId;

  final int index;

  final List<BankDetailEntity> bankId;

  @override
  String toString() {
    return 'InvestorProfileRouteArgs{key: $key, userId: $userId, index: $index, bankId: $bankId}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegistrationProcessStepPage]
class RegistrationProcessStepRoute extends PageRouteInfo<void> {
  const RegistrationProcessStepRoute({List<PageRouteInfo>? children})
      : super(
          RegistrationProcessStepRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationProcessStepRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<RegistrationRouteArgs> {
  RegistrationRoute({
    Key? key,
    required String type,
    PageController? pageController,
    List<PageRouteInfo>? children,
  }) : super(
          RegistrationRoute.name,
          args: RegistrationRouteArgs(
            key: key,
            type: type,
            pageController: pageController,
          ),
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const PageInfo<RegistrationRouteArgs> page =
      PageInfo<RegistrationRouteArgs>(name);
}

class RegistrationRouteArgs {
  const RegistrationRouteArgs({
    this.key,
    required this.type,
    this.pageController,
  });

  final Key? key;

  final String type;

  final PageController? pageController;

  @override
  String toString() {
    return 'RegistrationRouteArgs{key: $key, type: $type, pageController: $pageController}';
  }
}

/// generated route for
/// [UnderReviewScreen]
class UnderReviewRoute extends PageRouteInfo<void> {
  const UnderReviewRoute({List<PageRouteInfo>? children})
      : super(
          UnderReviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnderReviewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ValidateOtpPage]
class ValidateOtpRoute extends PageRouteInfo<ValidateOtpRouteArgs> {
  ValidateOtpRoute({
    Key? key,
    required String mobileNumber,
    List<PageRouteInfo>? children,
  }) : super(
          ValidateOtpRoute.name,
          args: ValidateOtpRouteArgs(
            key: key,
            mobileNumber: mobileNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'ValidateOtpRoute';

  static const PageInfo<ValidateOtpRouteArgs> page =
      PageInfo<ValidateOtpRouteArgs>(name);
}

class ValidateOtpRouteArgs {
  const ValidateOtpRouteArgs({
    this.key,
    required this.mobileNumber,
  });

  final Key? key;

  final String mobileNumber;

  @override
  String toString() {
    return 'ValidateOtpRouteArgs{key: $key, mobileNumber: $mobileNumber}';
  }
}

/// generated route for
/// [Walkthrough1Page]
class Walkthrough1Route extends PageRouteInfo<void> {
  const Walkthrough1Route({List<PageRouteInfo>? children})
      : super(
          Walkthrough1Route.name,
          initialChildren: children,
        );

  static const String name = 'Walkthrough1Route';

  static const PageInfo<void> page = PageInfo<void>(name);
}
