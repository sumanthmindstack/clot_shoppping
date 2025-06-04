import '../../domain/entity/account_summary_data_entity.dart';

class AccountSummaryDataResponseModel extends AccountSummaryDataEntity {
  AccountSummaryDataResponseModel({
    required super.data,
    required super.excelDownloadLink,
    required super.meta,
  });

  factory AccountSummaryDataResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountSummaryDataResponseModel(
      data: (json['data'] as List?)
              ?.map((e) => AccountSummaryModel.fromJson(e))
              .toList() ??
          [],
      excelDownloadLink: json['excelDownloadLink'] ?? '',
      meta: json['meta'] != null
          ? AccountSummaryMetaModel.fromJson(json['meta'])
          : AccountSummaryMetaModel(total: 0, totalPages: 0, currentPage: '1'),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data!.map((e) => e).toList(),
        'excelDownloadLink': excelDownloadLink,
        'meta': meta,
      };
}

class AccountSummaryModel extends InvestmentAccountEntity {
  AccountSummaryModel({
    required super.investmentAccountId,
    required super.investedAmount,
    required super.currentValue,
    required super.unrealizedGain,
    required super.absoluteReturn,
    required super.cagr,
    required super.userDetails,
  });

  factory AccountSummaryModel.fromJson(Map<String, dynamic> json) {
    return AccountSummaryModel(
      investmentAccountId: json['investment_account_id'] ?? 0,
      investedAmount: (json['invested_amount'] as num?)?.toDouble() ?? 0.0,
      currentValue: json['current_value'] ?? '',
      unrealizedGain: json['unrealized_gain'] ?? '',
      absoluteReturn: json['absolute_return'] ?? '',
      cagr: json['cagr'] ?? '',
      userDetails: json['user_details'] != null
          ? UserDetailsModel.fromJson(json['user_details'])
          : UserDetailsModel(id: '', name: '', email: '', mobile: '', role: ''),
    );
  }

  Map<String, dynamic> toJson() => {
        'investment_account_id': investmentAccountId,
        'invested_amount': investedAmount,
        'current_value': currentValue,
        'unrealized_gain': unrealizedGain,
        'absolute_return': absoluteReturn,
        'cagr': cagr,
        'user_details': userDetails,
      };
}

class UserDetailsModel extends UserDetailsEntity {
  UserDetailsModel({
    required super.id,
    required super.name,
    required super.email,
    required super.mobile,
    required super.role,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'role': role,
      };
}

class AccountSummaryMetaModel extends MetaEntity {
  AccountSummaryMetaModel({
    required super.total,
    required super.totalPages,
    required super.currentPage,
  });

  factory AccountSummaryMetaModel.fromJson(Map<String, dynamic> json) {
    return AccountSummaryMetaModel(
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? '1',
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'totalPages': totalPages,
        'currentPage': currentPage,
      };
}
