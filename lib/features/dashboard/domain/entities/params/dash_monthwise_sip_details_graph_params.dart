import 'package:json_annotation/json_annotation.dart';

part 'dash_monthwise_sip_details_graph_params.g.dart';

@JsonSerializable()
class DashMonthwiseSipDetailsGraphParams {
  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'year')
  final int year;

  DashMonthwiseSipDetailsGraphParams({
    required this.type,
    required this.year,
  });

  factory DashMonthwiseSipDetailsGraphParams.fromJson(
          Map<String, dynamic> json) =>
      _$DashMonthwiseSipDetailsGraphParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashMonthwiseSipDetailsGraphParamsToJson(this);
}
