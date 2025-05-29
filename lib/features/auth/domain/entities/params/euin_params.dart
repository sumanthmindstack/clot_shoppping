import 'package:json_annotation/json_annotation.dart';

part 'euin_params.g.dart';

@JsonSerializable(explicitToJson: true)
class EuinParams {
  @JsonKey(name: 'euin_details')
  final List<EuinDetails> euinDetails;

  @JsonKey(name: 'mfd_id')
  final int mfdId;

  @JsonKey(name: 'user_id')
  final int userId;

  EuinParams({
    required this.euinDetails,
    required this.mfdId,
    required this.userId,
  });

  factory EuinParams.fromJson(Map<String, dynamic> json) =>
      _$EuinParamsFromJson(json);

  Map<String, dynamic> toJson() => _$EuinParamsToJson(this);
}

@JsonSerializable()
class EuinDetails {
  @JsonKey(name: 'euin_code')
  final String euinCode;

  @JsonKey(name: 'euin_from')
  final String euinFrom;

  @JsonKey(name: 'euin_to')
  final String euinTo;

  EuinDetails({
    required this.euinCode,
    required this.euinFrom,
    required this.euinTo,
  });

  factory EuinDetails.fromJson(Map<String, dynamic> json) =>
      _$EuinDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$EuinDetailsToJson(this);
}
