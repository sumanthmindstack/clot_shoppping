import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_kyc_user_list_params.g.dart';

@JsonSerializable()
class GetKycUserListParams {
  @JsonKey(name: 'fields')
  final String fields;

  @JsonKey(name: 'limit')
  final int limit;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'join')
  final String join;

  @JsonKey(name: 's')
  final String searchData;

  GetKycUserListParams({
    required this.fields,
    required this.limit,
    required this.page,
    required this.join,
    required this.searchData,
  });

  /// Factory to create instance from search term
  factory GetKycUserListParams.fromSearchTerm({
    required String searchTerm,
    required int limit,
    required int page,
  }) {
    final queryMap = {
      "\$or": [
        {
          "email": {"\$cont": searchTerm}
        },
        {
          "full_name": {"\$cont": searchTerm}
        },
        {
          "user_onboarding_details.full_name": {"\$cont": searchTerm}
        },
        {
          "mobile": {"\$cont": searchTerm}
        },
      ],
    };

    return GetKycUserListParams(
      fields:
          'id,email,full_name,country_code,mobile,mobile_verified,is_active,is_blocked,pan',
      limit: limit,
      page: page,
      join: 'user_onboarding_details',
      searchData: jsonEncode(queryMap),
    );
  }

  factory GetKycUserListParams.fromJson(Map<String, dynamic> json) =>
      _$GetKycUserListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetKycUserListParamsToJson(this);
}
