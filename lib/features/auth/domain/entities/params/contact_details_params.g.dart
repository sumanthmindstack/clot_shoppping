// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetailsParams _$ContactDetailsParamsFromJson(
        Map<String, dynamic> json) =>
    ContactDetailsParams(
      alternateEmail: json['alternate_email'] as String,
      alternateMobile: (json['alternate_mobile'] as num).toInt(),
      communicationAlternateEmail:
          json['communication_alternate_email'] as String,
      communicationAlternateMobile:
          (json['communication_alternate_mobile'] as num).toInt(),
      communicationPrimaryEmail: json['communication_primary_email'] as String,
      communicationPrimaryLandline:
          (json['communication_primary_landline'] as num).toInt(),
      communicationPrimaryMobile:
          (json['communication_primary_mobile'] as num).toInt(),
      primaryEmail: json['primary_email'] as String,
      primaryLandline: (json['primary_landline'] as num).toInt(),
      primaryMobile: (json['primary_mobile'] as num).toInt(),
      id: json['id'] as String,
    );

Map<String, dynamic> _$ContactDetailsParamsToJson(
        ContactDetailsParams instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alternate_email': instance.alternateEmail,
      'alternate_mobile': instance.alternateMobile,
      'communication_alternate_email': instance.communicationAlternateEmail,
      'communication_alternate_mobile': instance.communicationAlternateMobile,
      'communication_primary_email': instance.communicationPrimaryEmail,
      'communication_primary_landline': instance.communicationPrimaryLandline,
      'communication_primary_mobile': instance.communicationPrimaryMobile,
      'primary_email': instance.primaryEmail,
      'primary_landline': instance.primaryLandline,
      'primary_mobile': instance.primaryMobile,
    };
