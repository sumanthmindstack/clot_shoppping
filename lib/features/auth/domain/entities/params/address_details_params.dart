import 'package:json_annotation/json_annotation.dart';

part 'address_details_params.g.dart';

@JsonSerializable()
class AddressDetailsParams {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'address1')
  final String address1;

  @JsonKey(name: 'address2')
  final String address2;

  @JsonKey(name: 'address3')
  final String address3;

  @JsonKey(name: 'area')
  final String area;

  @JsonKey(name: 'city')
  final String city;

  @JsonKey(name: 'state')
  final String state;

  @JsonKey(name: 'country')
  final String country;

  @JsonKey(name: 'pincode')
  final String pincode;

  @JsonKey(name: 'communication_address1')
  final String communicationAddress1;

  @JsonKey(name: 'communication_address2')
  final String communicationAddress2;

  @JsonKey(name: 'communication_address3')
  final String communicationAddress3;

  @JsonKey(name: 'communication_area')
  final String communicationArea;

  @JsonKey(name: 'communication_city')
  final String communicationCity;

  @JsonKey(name: 'communication_state')
  final String communicationState;

  @JsonKey(name: 'communication_country')
  final String communicationCountry;

  @JsonKey(name: 'communication_pincode')
  final String communicationPincode;

  AddressDetailsParams({
    required this.id,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.area,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.communicationAddress1,
    required this.communicationAddress2,
    required this.communicationAddress3,
    required this.communicationArea,
    required this.communicationCity,
    required this.communicationState,
    required this.communicationCountry,
    required this.communicationPincode,
  });

  factory AddressDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$AddressDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDetailsParamsToJson(this);
}
