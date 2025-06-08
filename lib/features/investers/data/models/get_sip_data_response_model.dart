import '../../domain/entity/get_sip_data_entity.dart';

class GetSipDataResponseModel extends GetSipDataEntity {
  GetSipDataResponseModel({
    required super.data,
    required super.meta,
  });

  factory GetSipDataResponseModel.fromJson(Map<String, dynamic> json) {
    return GetSipDataResponseModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => SipDataModel.fromJson(e))
              .toList() ??
          [],
      meta: json['meta'] != null ? MetaModel.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data!.map((e) => (e as SipDataModel).toJson()).toList(),
        if (meta != null) 'meta': meta,
      };
}

class SipDataModel extends SipDataEntity {
  SipDataModel({
    required super.id,
    required super.state,
    required super.mfInvestmentAccount,
    required super.folioNumber,
    required super.systematic,
    required super.frequency,
    required super.scheme,
    required super.autoGenerateInstallments,
    required super.installmentDay,
    required super.startDate,
    required super.endDate,
    required super.requestedActivationDate,
    required super.numberOfInstallments,
    required super.nextInstallmentDate,
    required super.previousInstallmentDate,
    required super.remainingInstallments,
    required super.amount,
    required super.paymentMethod,
    required super.paymentSource,
    required super.purpose,
    required super.sourceRefId,
    required super.euin,
    required super.partner,
    required super.createdAt,
    required super.updatedAt,
    required super.activatedAt,
    required super.cancelledAt,
    required super.completedAt,
    required super.failedAt,
    required super.cancellationScheduledOn,
    required super.cancellationCode,
    required super.reason,
    required super.gateway,
    required super.userIp,
    required super.serverIp,
    required super.initiatedBy,
    required super.initiatedVia,
    required super.userId,
    required super.transactionBasketItemId,
    required super.user,
    required super.fundName,
    required super.logoUrl,
  });

  factory SipDataModel.fromJson(Map<String, dynamic> json) {
    return SipDataModel(
      id: json['id'],
      state: json['state'],
      mfInvestmentAccount: json['mf_investment_account'],
      folioNumber: json['folio_number'],
      systematic: json['systematic'],
      frequency: json['frequency'],
      scheme: json['scheme'],
      autoGenerateInstallments: json['auto_generate_installments'],
      installmentDay: json['installment_day'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      requestedActivationDate: json['requested_activation_date'],
      numberOfInstallments: json['number_of_installments'],
      nextInstallmentDate: json['next_installment_date'],
      previousInstallmentDate: json['previous_installment_date'],
      remainingInstallments: json['remaining_installments'],
      amount: json['amount'],
      paymentMethod: json['payment_method'],
      paymentSource: json['payment_source'],
      purpose: json['purpose'],
      sourceRefId: json['source_ref_id'],
      euin: json['euin'],
      partner: json['partner'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      activatedAt: json['activated_at'],
      cancelledAt: json['cancelled_at'],
      completedAt: json['completed_at'],
      failedAt: json['failed_at'],
      cancellationScheduledOn: json['cancellation_scheduled_on'],
      cancellationCode: json['cancellation_code'],
      reason: json['reason'],
      gateway: json['gateway'],
      userIp: json['user_ip'],
      serverIp: json['server_ip'],
      initiatedBy: json['initiated_by'],
      initiatedVia: json['initiated_via'],
      userId: json['user_id'],
      transactionBasketItemId: json['transaction_basket_item_id'],
      user: json['user'] != null
          ? SipUserModel.fromJson(json['user'])
          : SipUserModel(
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
        'mf_investment_account': mfInvestmentAccount,
        'folio_number': folioNumber,
        'systematic': systematic,
        'frequency': frequency,
        'scheme': scheme,
        'auto_generate_installments': autoGenerateInstallments,
        'installment_day': installmentDay,
        'start_date': startDate,
        'end_date': endDate,
        'requested_activation_date': requestedActivationDate,
        'number_of_installments': numberOfInstallments,
        'next_installment_date': nextInstallmentDate,
        'previous_installment_date': previousInstallmentDate,
        'remaining_installments': remainingInstallments,
        'amount': amount,
        'payment_method': paymentMethod,
        'payment_source': paymentSource,
        'purpose': purpose,
        'source_ref_id': sourceRefId,
        'euin': euin,
        'partner': partner,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'activated_at': activatedAt,
        'cancelled_at': cancelledAt,
        'completed_at': completedAt,
        'failed_at': failedAt,
        'cancellation_scheduled_on': cancellationScheduledOn,
        'cancellation_code': cancellationCode,
        'reason': reason,
        'gateway': gateway,
        'user_ip': userIp,
        'server_ip': serverIp,
        'initiated_by': initiatedBy,
        'initiated_via': initiatedVia,
        'user_id': userId,
        'transaction_basket_item_id': transactionBasketItemId,
        'user': user,
        'fund_name': fundName,
        'logo_url': logoUrl,
      };
}

class SipUserModel extends SipUserEntity {
  SipUserModel({
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

  factory SipUserModel.fromJson(Map<String, dynamic> json) {
    return SipUserModel(
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
