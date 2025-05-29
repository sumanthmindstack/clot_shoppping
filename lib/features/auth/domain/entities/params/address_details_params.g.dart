// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDetailsParams _$AddressDetailsParamsFromJson(
        Map<String, dynamic> json) =>
    AddressDetailsParams(
      id: (json['id'] as num).toInt(),
      address1: json['address1'] as String,
      address2: json['address2'] as String,
      address3: json['address3'] as String,
      area: json['area'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      pincode: json['pincode'] as String,
      communicationAddress1: json['communication_address1'] as String,
      communicationAddress2: json['communication_address2'] as String,
      communicationAddress3: json['communication_address3'] as String,
      communicationArea: json['communication_area'] as String,
      communicationCity: json['communication_city'] as String,
      communicationState: json['communication_state'] as String,
      communicationCountry: json['communication_country'] as String,
      communicationPincode: json['communication_pincode'] as String,
    );

Map<String, dynamic> _$AddressDetailsParamsToJson(
        AddressDetailsParams instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'area': instance.area,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'pincode': instance.pincode,
      'communication_address1': instance.communicationAddress1,
      'communication_address2': instance.communicationAddress2,
      'communication_address3': instance.communicationAddress3,
      'communication_area': instance.communicationArea,
      'communication_city': instance.communicationCity,
      'communication_state': instance.communicationState,
      'communication_country': instance.communicationCountry,
      'communication_pincode': instance.communicationPincode,
    };
