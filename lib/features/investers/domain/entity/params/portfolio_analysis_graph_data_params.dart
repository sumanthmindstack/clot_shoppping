import 'package:json_annotation/json_annotation.dart';

part 'portfolio_analysis_graph_data_params.g.dart';

@JsonSerializable()
class PortfolioAnalysisGraphDataParams {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'duration')
  final int duration;

  PortfolioAnalysisGraphDataParams({
    required this.userId,
    required this.duration,
  });

  factory PortfolioAnalysisGraphDataParams.fromJson(
          Map<String, dynamic> json) =>
      _$PortfolioAnalysisGraphDataParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PortfolioAnalysisGraphDataParamsToJson(this);
}
