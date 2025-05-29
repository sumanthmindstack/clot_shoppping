// user.dart
import 'package:hive/hive.dart';

part 'user_local.g.dart';

@HiveType(typeId: 0)
class UserLocal {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? profile;

  @HiveField(4)
  final String? lastName;

  @HiveField(5)
  final String? address;

  @HiveField(6)
  final String? dob;

  @HiveField(7)
  final String? phone;

  @HiveField(8)
  final bool? isOnboarded;

  @HiveField(9)
  final String? onboardingStep;

  @HiveField(10)
  final bool? isKycVerified;

  @HiveField(11)
  final bool? isVerified;

  UserLocal(
      {required this.id,
      required this.name,
      required this.email,
      this.profile,
      this.address,
      this.dob,
      this.lastName,
      this.phone,
      this.isOnboarded,
      this.onboardingStep,
      this.isKycVerified,
      this.isVerified});
}
