import '../../domain/entity/get_swp_data_entity.dart';

class GetSwpDataResponseModel extends GetSwpDataEntity {
  GetSwpDataResponseModel({
    required super.data,
    required super.meta,
  });

  factory GetSwpDataResponseModel.fromJson(Map<String, dynamic> json) {
    return GetSwpDataResponseModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => SwpDataModel.fromJson(e))
              .toList() ??
          [],
      meta: json['meta'] != null ? MetaModel.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => (e as SwpDataModel).toJson()).toList(),
        if (meta != null) 'meta': (meta as MetaModel).toJson(),
      };
}

class SwpDataModel extends SwpDataEntity {
  SwpDataModel({
    required super.id,
    required super.state,
    required super.systematic,
    required super.mfInvestmentAccount,
    required super.folioNumber,
    required super.frequency,
    required super.scheme,
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
    required super.fundName,
    required super.logoUrl,
  });

  factory SwpDataModel.fromJson(Map<String, dynamic> json) {
    return SwpDataModel(
      id: json['id'],
      state: json['state'],
      systematic: json['systematic'],
      mfInvestmentAccount: json['mf_investment_account'],
      folioNumber: json['folio_number'],
      frequency: json['frequency'],
      scheme: json['scheme'],
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
          ? SwpUserModel.fromJson(json['user'])
          : SwpUserModel(
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
      fundName: json['fund_name'],
      logoUrl: json['logo_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'state': state,
        'systematic': systematic,
        'mf_investment_account': mfInvestmentAccount,
        'folio_number': folioNumber,
        'frequency': frequency,
        'scheme': scheme,
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
        'user': user,
        'fund_name': fundName,
        'logo_url': logoUrl,
      };
}

class SwpUserModel extends SwpUserEntity {
  SwpUserModel({
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

  factory SwpUserModel.fromJson(Map<String, dynamic> json) {
    return SwpUserModel(
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
