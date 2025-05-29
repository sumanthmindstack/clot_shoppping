import 'package:json_annotation/json_annotation.dart';

part 'ria_patch_params.g.dart';

@JsonSerializable()
class RiaPatchParams {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'equity_name')
  final String equityName;

  @JsonKey(name: 'equity_short_code')
  final String equityShortCode;

  @JsonKey(name: 'pan')
  final String pan;

  @JsonKey(name: 'ria_code')
  final String riaCode;

  @JsonKey(name: 'sip_demat')
  final bool sipDemat;

  @JsonKey(name: 'tan_code')
  final String tanCode;

  @JsonKey(name: 'website')
  final String website;

  RiaPatchParams({
    required this.id,
    required this.equityName,
    required this.equityShortCode,
    required this.pan,
    required this.riaCode,
    required this.sipDemat,
    required this.tanCode,
    required this.website,
  });

  factory RiaPatchParams.fromJson(Map<String, dynamic> json) =>
      _$RiaPatchParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RiaPatchParamsToJson(this);
}
