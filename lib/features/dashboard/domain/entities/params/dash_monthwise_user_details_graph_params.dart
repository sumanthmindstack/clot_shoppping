import 'package:json_annotation/json_annotation.dart';

part 'dash_monthwise_user_details_graph_params.g.dart';

@JsonSerializable()
class DashMonthwiseUserDetailsGraphParams {
  @JsonKey(name: 'filter')
  final String filter;

  @JsonKey(name: 'year')
  final int year;

  DashMonthwiseUserDetailsGraphParams({
    required this.filter,
    required this.year,
  });

  factory DashMonthwiseUserDetailsGraphParams.fromJson(
          Map<String, dynamic> json) =>
      _$DashMonthwiseUserDetailsGraphParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashMonthwiseUserDetailsGraphParamsToJson(this);
}
