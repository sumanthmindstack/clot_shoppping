import 'package:json_annotation/json_annotation.dart';

part 'dash_monthwise_trans_details_graph_params.g.dart';

@JsonSerializable()
class DashMonthwiseTransDetailsGraphParams {
  @JsonKey(name: 'year')
  final int year;

  DashMonthwiseTransDetailsGraphParams({
    required this.year,
  });

  factory DashMonthwiseTransDetailsGraphParams.fromJson(
          Map<String, dynamic> json) =>
      _$DashMonthwiseTransDetailsGraphParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashMonthwiseTransDetailsGraphParamsToJson(this);
}
