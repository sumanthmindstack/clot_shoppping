// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'euin_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EuinParams _$EuinParamsFromJson(Map<String, dynamic> json) => EuinParams(
      euinDetails: (json['euin_details'] as List<dynamic>)
          .map((e) => EuinDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      mfdId: (json['mfd_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$EuinParamsToJson(EuinParams instance) =>
    <String, dynamic>{
      'euin_details': instance.euinDetails.map((e) => e.toJson()).toList(),
      'mfd_id': instance.mfdId,
      'user_id': instance.userId,
    };

EuinDetails _$EuinDetailsFromJson(Map<String, dynamic> json) => EuinDetails(
      euinCode: json['euin_code'] as String,
      euinFrom: json['euin_from'] as String,
      euinTo: json['euin_to'] as String,
    );

Map<String, dynamic> _$EuinDetailsToJson(EuinDetails instance) =>
    <String, dynamic>{
      'euin_code': instance.euinCode,
      'euin_from': instance.euinFrom,
      'euin_to': instance.euinTo,
    };
