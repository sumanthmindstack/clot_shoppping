// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dash_monthwise_user_details_graph_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashMonthwiseUserDetailsGraphParams
    _$DashMonthwiseUserDetailsGraphParamsFromJson(Map<String, dynamic> json) =>
        DashMonthwiseUserDetailsGraphParams(
          filter: json['filter'] as String,
          year: (json['year'] as num).toInt(),
        );

Map<String, dynamic> _$DashMonthwiseUserDetailsGraphParamsToJson(
        DashMonthwiseUserDetailsGraphParams instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'year': instance.year,
    };
