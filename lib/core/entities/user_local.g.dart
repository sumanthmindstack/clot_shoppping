// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLocalAdapter extends TypeAdapter<UserLocal> {
  @override
  final int typeId = 0;

  @override
  UserLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocal(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      profile: fields[3] as String?,
      address: fields[5] as String?,
      dob: fields[6] as String?,
      lastName: fields[4] as String?,
      phone: fields[7] as String?,
      isOnboarded: fields[8] as bool?,
      onboardingStep: fields[9] as String?,
      isKycVerified: fields[10] as bool?,
      isVerified: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserLocal obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.profile)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.dob)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.isOnboarded)
      ..writeByte(9)
      ..write(obj.onboardingStep)
      ..writeByte(10)
      ..write(obj.isKycVerified)
      ..writeByte(11)
      ..write(obj.isVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
