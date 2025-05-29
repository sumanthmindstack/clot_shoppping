import '../../domain/entities/user_entity.dart';

class UserResponseModel extends UserResponseEntity {
  const UserResponseModel({
    super.id,
    super.fullName,
    super.email,
    super.mpin,
    super.mobile,
    super.mobileVerified,
    super.isActive,
    super.isBlocked,
    super.otp,
    super.countryCode,
    super.riskProfileId,
    super.isDailyPortfolioUpdates,
    super.isWhatsappNotifications,
    super.isEnableBiometrics,
    super.isLead,
    super.userCode,
    super.referralCode,
    super.fcmToken,
    super.emailOtp,
    super.isEmailVerified,
    super.role,
    super.createdAt,
    super.updatedAt,
    super.accessToken,
    super.riskProfile,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        id: json['id'] as int?,
        fullName: json['full_name'] as String?,
        email: json['email'] as String?,
        mpin: json['mpin'] as int?,
        mobile: json['mobile'] as String?,
        mobileVerified: json['mobile_verified'] as bool?,
        isActive: json['is_active'] as bool?,
        isBlocked: json['is_blocked'] as bool?,
        otp: json['otp'] as int?,
        countryCode: json['country_code'] as String?,
        riskProfileId: json['risk_profile_id'] as int?,
        isDailyPortfolioUpdates: json['is_daily_portfolio_updates'] as bool?,
        isWhatsappNotifications: json['is_whatsapp_notifications'] as bool?,
        isEnableBiometrics: json['is_enable_biometrics'] as bool?,
        isLead: json['is_lead'] as bool?,
        userCode: json['user_code'] as String?,
        referralCode: json['referral_code'] as String?,
        fcmToken: json['fcmToken'] as String?,
        emailOtp: json['email_otp'] as String?,
        isEmailVerified: json['is_email_verified'] as bool?,
        role: json['role'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        accessToken: json['access_token'] as String?,
        riskProfile: json['risk_profile'] == null
            ? null
            : RiskProfileModel.fromJson(json['risk_profile']),
      );

  Map<String, dynamic> toJson(UserResponseModel instance) => <String, dynamic>{
        'id': instance.id,
        'full_name': instance.fullName,
        'email': instance.email,
        'mpin': instance.mpin,
        'mobile': instance.mobile,
        'mobile_verified': instance.mobileVerified,
        'is_active': instance.isActive,
        'is_blocked': instance.isBlocked,
        'otp': instance.otp,
        'country_code': instance.countryCode,
        'risk_profile_id': instance.riskProfileId,
        'is_daily_portfolio_updates': instance.isDailyPortfolioUpdates,
        'is_whatsapp_notifications': instance.isWhatsappNotifications,
        'is_enable_biometrics': instance.isEnableBiometrics,
        'is_lead': instance.isLead,
        'user_code': instance.userCode,
        'referral_code': instance.referralCode,
        'fcmToken': instance.fcmToken,
        'email_otp': instance.emailOtp,
        'is_email_verified': instance.isEmailVerified,
        'role': instance.role,
        'created_at': instance.createdAt?.toIso8601String(),
        'updated_at': instance.updatedAt?.toIso8601String(),
        'access_token': instance.accessToken,
        'risk_profile': instance.riskProfile,
      };
}

class RiskProfileModel extends RiskProfileEntity {
  const RiskProfileModel({
    super.id,
    super.name,
    super.description,
    super.low,
    super.high,
    super.isActive,
    super.isDeleted,
    super.displayEquityAllocation,
    super.minEquityAllocation,
    super.maxEquityAllocation,
    super.displayDebtAllocation,
    super.minDebtAllocation,
    super.maxDebtAllocation,
    super.displayLiquidAllocation,
    super.minLiquidAllocation,
    super.maxLiquidAllocation,
    super.modelPortfolioId,
    super.createdAt,
    super.updatedAt,
  });

  factory RiskProfileModel.fromJson(Map<String, dynamic> json) =>
      RiskProfileModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        low: json['low'] as int?,
        high: json['high'] as int?,
        isActive: json['is_active'] as bool?,
        isDeleted: json['is_deleted'] as bool?,
        displayEquityAllocation: json['display_equity_allocation'] as String?,
        minEquityAllocation: json['min_equity_allocation'] as int?,
        maxEquityAllocation: json['max_equity_allocation'] as int?,
        displayDebtAllocation: json['display_debt_allocation'] as String?,
        minDebtAllocation: json['min_debt_allocation'] as int?,
        maxDebtAllocation: json['max_debt_allocation'] as int?,
        displayLiquidAllocation: json['display_liquid_allocation'] as String?,
        minLiquidAllocation: json['min_liquid_allocation'] as int?,
        maxLiquidAllocation: json['max_liquid_allocation'] as int?,
        modelPortfolioId: json['model_portfolio_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'low': low,
        'high': high,
        'is_active': isActive,
        'is_deleted': isDeleted,
        'display_equity_allocation': displayEquityAllocation,
        'min_equity_allocation': minEquityAllocation,
        'max_equity_allocation': maxEquityAllocation,
        'display_debt_allocation': displayDebtAllocation,
        'min_debt_allocation': minDebtAllocation,
        'max_debt_allocation': maxDebtAllocation,
        'display_liquid_allocation': displayLiquidAllocation,
        'min_liquid_allocation': minLiquidAllocation,
        'max_liquid_allocation': maxLiquidAllocation,
        'model_portfolio_id': modelPortfolioId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
