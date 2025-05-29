import 'package:equatable/equatable.dart';

class RiskProfileEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? low;
  final int? high;
  final bool? isActive;
  final bool? isDeleted;
  final String? displayEquityAllocation;
  final int? minEquityAllocation;
  final int? maxEquityAllocation;
  final String? displayDebtAllocation;
  final int? minDebtAllocation;
  final int? maxDebtAllocation;
  final String? displayLiquidAllocation;
  final int? minLiquidAllocation;
  final int? maxLiquidAllocation;
  final int? modelPortfolioId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const RiskProfileEntity({
    this.id,
    this.name,
    this.description,
    this.low,
    this.high,
    this.isActive,
    this.isDeleted,
    this.displayEquityAllocation,
    this.minEquityAllocation,
    this.maxEquityAllocation,
    this.displayDebtAllocation,
    this.minDebtAllocation,
    this.maxDebtAllocation,
    this.displayLiquidAllocation,
    this.minLiquidAllocation,
    this.maxLiquidAllocation,
    this.modelPortfolioId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        low,
        high,
        isActive,
        isDeleted,
        displayEquityAllocation,
        minEquityAllocation,
        maxEquityAllocation,
        displayDebtAllocation,
        minDebtAllocation,
        maxDebtAllocation,
        displayLiquidAllocation,
        minLiquidAllocation,
        maxLiquidAllocation,
        modelPortfolioId,
        createdAt,
        updatedAt,
      ];
}

class UserResponseEntity extends Equatable {
  final int? id;
  final String? fullName;
  final String? email;
  final int? mpin;
  final String? mobile;
  final bool? mobileVerified;
  final bool? isActive;
  final bool? isBlocked;
  final int? otp;
  final String? countryCode;
  final int? riskProfileId;
  final bool? isDailyPortfolioUpdates;
  final bool? isWhatsappNotifications;
  final bool? isEnableBiometrics;
  final bool? isLead;
  final String? userCode;
  final String? referralCode;
  final String? fcmToken;
  final String? emailOtp;
  final bool? isEmailVerified;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final RiskProfileEntity? riskProfile;
  final String? accessToken;

  const UserResponseEntity({
    this.id,
    this.fullName,
    this.email,
    this.mpin,
    this.mobile,
    this.mobileVerified,
    this.isActive,
    this.isBlocked,
    this.otp,
    this.countryCode,
    this.riskProfileId,
    this.isDailyPortfolioUpdates,
    this.isWhatsappNotifications,
    this.isEnableBiometrics,
    this.isLead,
    this.userCode,
    this.referralCode,
    this.fcmToken,
    this.emailOtp,
    this.isEmailVerified,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.riskProfile,
    this.accessToken,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        mpin,
        mobile,
        mobileVerified,
        isActive,
        isBlocked,
        otp,
        countryCode,
        riskProfileId,
        isDailyPortfolioUpdates,
        isWhatsappNotifications,
        isEnableBiometrics,
        isLead,
        userCode,
        referralCode,
        fcmToken,
        emailOtp,
        isEmailVerified,
        role,
        createdAt,
        updatedAt,
        riskProfile,
        accessToken,
      ];
}
