import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:maxwealth_distributor_app/config/routes/app_router.dart';

class AuthBiometric {
  final LocalAuthentication localAuth = LocalAuthentication();

  Future<void> authenticateWithBiometrics(BuildContext context) async {
    try {
      bool isAuthenticated = await localAuth.authenticate(
        localizedReason: "Authenticate to access your dashboard",
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (isAuthenticated) {
        AutoRouter.of(context).replace(const DashboardRoute());
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Handle no biometrics enrolled
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No biometrics enrolled")),
        );
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Biometrics locked out")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Authentication error: ${e.message}")),
        );
      }
    }
  }
}
