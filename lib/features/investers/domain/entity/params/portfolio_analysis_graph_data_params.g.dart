// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_analysis_graph_data_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioAnalysisGraphDataParams _$PortfolioAnalysisGraphDataParamsFromJson(
        Map<String, dynamic> json) =>
    PortfolioAnalysisGraphDataParams(
      userId: (json['user_id'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
    );

Map<String, dynamic> _$PortfolioAnalysisGraphDataParamsToJson(
        PortfolioAnalysisGraphDataParams instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'duration': instance.duration,
    };
