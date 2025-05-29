import 'package:json_annotation/json_annotation.dart';

part 'contact_details_params.g.dart';

@JsonSerializable()
class ContactDetailsParams {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'alternate_email')
  final String alternateEmail;

  @JsonKey(name: 'alternate_mobile')
  final int alternateMobile;

  @JsonKey(name: 'communication_alternate_email')
  final String communicationAlternateEmail;

  @JsonKey(name: 'communication_alternate_mobile')
  final int communicationAlternateMobile;

  @JsonKey(name: 'communication_primary_email')
  final String communicationPrimaryEmail;

  @JsonKey(name: 'communication_primary_landline')
  final int communicationPrimaryLandline;

  @JsonKey(name: 'communication_primary_mobile')
  final int communicationPrimaryMobile;

  @JsonKey(name: 'primary_email')
  final String primaryEmail;

  @JsonKey(name: 'primary_landline')
  final int primaryLandline;

  @JsonKey(name: 'primary_mobile')
  final int primaryMobile;

  ContactDetailsParams(
      {required this.alternateEmail,
      required this.alternateMobile,
      required this.communicationAlternateEmail,
      required this.communicationAlternateMobile,
      required this.communicationPrimaryEmail,
      required this.communicationPrimaryLandline,
      required this.communicationPrimaryMobile,
      required this.primaryEmail,
      required this.primaryLandline,
      required this.primaryMobile,
      required this.id});

  factory ContactDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDetailsParamsToJson(this);
}
