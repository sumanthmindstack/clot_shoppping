import '../../domain/entity/get_stp_data_entity.dart';

class GetStpDataResponseModel extends GetStpDataEntity {
  GetStpDataResponseModel({
    required super.data,
    required super.meta,
  });

  factory GetStpDataResponseModel.fromJson(Map<String, dynamic> json) {
    return GetStpDataResponseModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => StpDataModel.fromJson(e))
              .toList() ??
          [],
      meta: json['meta'] != null ? MetaModel.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => (e as StpDataModel).toJson()).toList(),
        if (meta != null) 'meta': (meta as MetaModel).toJson(),
      };
}

class StpDataModel extends StpDataEntity {
  StpDataModel({
    required super.id,
    required super.state,
    required super.systematic,
    required super.mfInvestmentAccount,
    required super.folioNumber,
    required super.frequency,
    required super.switchInScheme,
    required super.switchOutScheme,
    required super.installmentDay,
    required super.startDate,
    required super.endDate,
    required super.numberOfInstallments,
    required super.autoGenerateInstallments,
    required super.nextInstallmentDate,
    required super.previousInstallmentDate,
    required super.remainingInstallments,
    required super.amount,
    required super.sourceRefId,
    required super.euin,
    required super.partner,
    required super.createdAt,
    required super.activatedAt,
    required super.requestedActivationDate,
    required super.cancelledAt,
    required super.completedAt,
    required super.failedAt,
    required super.cancellationScheduledOn,
    required super.gateway,
    required super.userIp,
    required super.serverIp,
    required super.initiatedBy,
    required super.initiatedVia,
    required super.reason,
    required super.userId,
    required super.transactionBasketItemId,
    required super.updatedAt,
    required super.user,
    required super.switchOutFundName,
    required super.switchOutLogoUrl,
    required super.switchInFundName,
    required super.switchInLogoUrl,
  });

  factory StpDataModel.fromJson(Map<String, dynamic> json) {
    return StpDataModel(
      id: json['id'],
      state: json['state'],
      systematic: json['systematic'],
      mfInvestmentAccount: json['mf_investment_account'],
      folioNumber: json['folio_number'],
      frequency: json['frequency'],
      switchInScheme: json['switch_in_scheme'],
      switchOutScheme: json['switch_out_scheme'],
      installmentDay: json['installment_day'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      numberOfInstallments: json['number_of_installments'],
      autoGenerateInstallments: json['auto_generate_installments'],
      nextInstallmentDate: json['next_installment_date'],
      previousInstallmentDate: json['previous_installment_date'],
      remainingInstallments: json['remaining_installments'],
      amount: json['amount'],
      sourceRefId: json['source_ref_id'],
      euin: json['euin'],
      partner: json['partner'],
      createdAt: json['created_at'],
      activatedAt: json['activated_at'],
      requestedActivationDate: json['requested_activation_date'],
      cancelledAt: json['cancelled_at'],
      completedAt: json['completed_at'],
      failedAt: json['failed_at'],
      cancellationScheduledOn: json['cancellation_scheduled_on'],
      gateway: json['gateway'],
      userIp: json['user_ip'],
      serverIp: json['server_ip'],
      initiatedBy: json['initiated_by'],
      initiatedVia: json['initiated_via'],
      reason: json['reason'],
      userId: json['user_id'],
      transactionBasketItemId: json['transaction_basket_item_id'],
      updatedAt: json['updated_at'],
      user: json['user'] != null
          ? StpUserModel.fromJson(json['user'])
          : StpUserModel(
              id: 0,
              fullName: '',
              email: '',
              mobile: '',
              role: '',
              isBulkUploaded: false,
              bulkUserFileId: null,
              createdAt: '',
              updatedAt: '',
            ),
      switchOutFundName: json['switch_out_fund_name'],
      switchOutLogoUrl: json['switch_out_logo_url'],
      switchInFundName: json['switch_in_fund_name'],
      switchInLogoUrl: json['switch_in_logo_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'state': state,
        'systematic': systematic,
        'mf_investment_account': mfInvestmentAccount,
        'folio_number': folioNumber,
        'frequency': frequency,
        'switch_in_scheme': switchInScheme,
        'switch_out_scheme': switchOutScheme,
        'installment_day': installmentDay,
        'start_date': startDate,
        'end_date': endDate,
        'number_of_installments': numberOfInstallments,
        'auto_generate_installments': autoGenerateInstallments,
        'next_installment_date': nextInstallmentDate,
        'previous_installment_date': previousInstallmentDate,
        'remaining_installments': remainingInstallments,
        'amount': amount,
        'source_ref_id': sourceRefId,
        'euin': euin,
        'partner': partner,
        'created_at': createdAt,
        'activated_at': activatedAt,
        'requested_activation_date': requestedActivationDate,
        'cancelled_at': cancelledAt,
        'completed_at': completedAt,
        'failed_at': failedAt,
        'cancellation_scheduled_on': cancellationScheduledOn,
        'gateway': gateway,
        'user_ip': userIp,
        'server_ip': serverIp,
        'initiated_by': initiatedBy,
        'initiated_via': initiatedVia,
        'reason': reason,
        'user_id': userId,
        'transaction_basket_item_id': transactionBasketItemId,
        'updated_at': updatedAt,
        'user': (user as StpUserModel).toJson(),
        'switch_out_fund_name': switchOutFundName,
        'switch_out_logo_url': switchOutLogoUrl,
        'switch_in_fund_name': switchInFundName,
        'switch_in_logo_url': switchInLogoUrl,
      };
}

class StpUserModel extends StpUserEntity {
  StpUserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.mobile,
    required super.role,
    required super.isBulkUploaded,
    required super.bulkUserFileId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory StpUserModel.fromJson(Map<String, dynamic> json) {
    return StpUserModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      mobile: json['mobile'],
      role: json['role'],
      isBulkUploaded: json['is_bulk_uploaded'],
      bulkUserFileId: json['bulk_user_file_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'mobile': mobile,
        'role': role,
        'is_bulk_uploaded': isBulkUploaded,
        'bulk_user_file_id': bulkUserFileId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class MetaModel extends MetaEntity {
  MetaModel({
    required super.page,
    required super.limit,
    required super.total,
    required super.totalPages,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      page: int.tryParse(json['page'].toString()) ?? 0,
      limit: int.tryParse(json['limit'].toString()) ?? 0,
      total: int.tryParse(json['total'].toString()) ?? 0,
      totalPages: int.tryParse(json['totalPages'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
        'total': total,
        'totalPages': totalPages,
      };
}
