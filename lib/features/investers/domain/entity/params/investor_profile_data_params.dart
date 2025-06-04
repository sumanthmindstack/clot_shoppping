import 'package:json_annotation/json_annotation.dart';

part 'investor_profile_data_params.g.dart';

@JsonSerializable()
class InvestorProfileDataParams {
  @JsonKey(name: 'fields')
  final String fields;

  @JsonKey(name: 'filter')
  final String filter;

  InvestorProfileDataParams({
    required this.fields,
    required this.filter,
  });

  factory InvestorProfileDataParams.withUserIdFilter(int userId) {
    final filterString = 'user_id||\$eq||$userId';

    const fieldsString =
        'id,is_kyc_compliant,pan,full_name,date_of_birth,father_name,mother_name,marital_status,occupation,annual_income,nationality,signature_url,photo_url,video_url,fp_esign_status,kyc_id,fp_photo_file_id,fp_video_file_id,fp_signature_file_id,aadhaar_number,fp_esign_id,status,lat,lng,fp_investor_id,fp_investment_account_old_id,fp_investment_account_id,fp_kyc_status,fp_kyc_reject_reasons,user_id,created_at,updated_at,gender,mobile,phone';

    return InvestorProfileDataParams(
      fields: fieldsString,
      filter: filterString,
    );
  }

  factory InvestorProfileDataParams.fromJson(Map<String, dynamic> json) =>
      _$InvestorProfileDataParamsFromJson(json);

  Map<String, dynamic> toJson() => _$InvestorProfileDataParamsToJson(this);
}
