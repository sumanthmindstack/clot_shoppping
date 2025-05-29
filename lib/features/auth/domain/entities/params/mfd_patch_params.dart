import 'package:json_annotation/json_annotation.dart';

part 'mfd_patch_params.g.dart';

@JsonSerializable()
class MfdPatchParams {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'arn_code')
  final String arnCode;

  @JsonKey(name: 'arn_start_date')
  final String arnStartDate;

  @JsonKey(name: 'arn_end_date')
  final String arnEndDate;

  @JsonKey(name: 'equity_name')
  final String equityName;

  @JsonKey(name: 'pan')
  final String pan;

  @JsonKey(name: 'sip_demat')
  final bool sipDemat;

  @JsonKey(name: 'tan_code')
  final String tanCode;

  @JsonKey(name: 'website')
  final String website;

  MfdPatchParams({
    required this.id,
    required this.arnCode,
    required this.arnStartDate,
    required this.arnEndDate,
    required this.equityName,
    required this.pan,
    required this.sipDemat,
    required this.tanCode,
    required this.website,
  });

  factory MfdPatchParams.fromJson(Map<String, dynamic> json) =>
      _$MfdPatchParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MfdPatchParamsToJson(this);
}
