import '../../domain/entity/get_switch_data_entity.dart';

class GetSwitchDataResponseModel extends GetSwitchDataEntity {
  GetSwitchDataResponseModel({
    required super.data,
    required super.meta,
  });

  factory GetSwitchDataResponseModel.fromJson(Map<String, dynamic> json) {
    return GetSwitchDataResponseModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => SwitchDataModel.fromJson(e))
              .toList() ??
          [],
      meta: json['meta'] != null ? MetaModel.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => (e as SwitchDataModel).toJson()).toList(),
        if (meta != null) 'meta': meta,
      };
}

class SwitchDataModel extends SwitchDataEntity {
  SwitchDataModel({
    required super.id,
    required super.fpId,
    required super.oldId,
    required super.mfInvestmentAccount,
    required super.folioNumber,
    required super.state,
    required super.amount,
    required super.units,
    required super.switchOutScheme,
    required super.switchInScheme,
    required super.plan,
    required super.switchedOutUnits,
    required super.switchedOutAmount,
    required super.switchedOutPrice,
    required super.switchedInUnits,
    required super.switchedInAmount,
    required super.switchedInPrice,
    required super.gateway,
    required super.tradedOn,
    required super.scheduledOn,
    required super.createdAt,
    required super.succeededAt,
    required super.submittedAt,
    required super.reversedAt,
    required super.failedAt,
    required super.confirmedAt,
    required super.sourceRefId,
    required super.userIp,
    required super.serverIp,
    required super.initiatedBy,
    required super.initiatedVia,
    required super.euin,
    required super.partner,
    required super.failureCode,
    required super.updatedAt,
    required super.userId,
    required super.transactionBasketItemId,
    required super.user,
    required super.switchOutFundName,
    required super.switchOutLogoUrl,
    required super.switchInFundName,
    required super.switchInLogoUrl,
  });

  factory SwitchDataModel.fromJson(Map<String, dynamic> json) {
    return SwitchDataModel(
      id: json['id'],
      fpId: json['fp_id'],
      oldId: json['old_id'],
      mfInvestmentAccount: json['mf_investment_account'],
      folioNumber: json['folio_number'],
      state: json['state'],
      amount: json['amount'],
      units: json['units'],
      switchOutScheme: json['switch_out_scheme'],
      switchInScheme: json['switch_in_scheme'],
      plan: json['plan'],
      switchedOutUnits: json['switched_out_units'],
      switchedOutAmount: json['switched_out_amount'],
      switchedOutPrice: json['switched_out_price'],
      switchedInUnits: json['switched_in_units'],
      switchedInAmount: json['switched_in_amount'],
      switchedInPrice: json['switched_in_price'],
      gateway: json['gateway'],
      tradedOn: json['traded_on'],
      scheduledOn: json['scheduled_on'],
      createdAt: json['created_at'],
      succeededAt: json['succeeded_at'],
      submittedAt: json['submitted_at'],
      reversedAt: json['reversed_at'],
      failedAt: json['failed_at'],
      confirmedAt: json['confirmed_at'],
      sourceRefId: json['source_ref_id'],
      userIp: json['user_ip'],
      serverIp: json['server_ip'],
      initiatedBy: json['initiated_by'],
      initiatedVia: json['initiated_via'],
      euin: json['euin'],
      partner: json['partner'],
      failureCode: json['failure_code'],
      updatedAt: json['updated_at'],
      userId: json['user_id'],
      transactionBasketItemId: json['transaction_basket_item_id'],
      user: json['user'] != null
          ? SwitchUserModel.fromJson(json['user'])
          : SwitchUserModel(
              id: 0,
              fullName: '',
              email: '',
              mobile: '',
              role: '',
              isBulkUploaded: false,
              bulkUserFileId: null,
              createdAt: '',
              updatedAt: '',
              password: null,
            ),
      switchOutFundName: json['switch_out_fund_name'],
      switchOutLogoUrl: json['switch_out_logo_url'],
      switchInFundName: json['switch_in_fund_name'],
      switchInLogoUrl: json['switch_in_logo_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fp_id': fpId,
        'old_id': oldId,
        'mf_investment_account': mfInvestmentAccount,
        'folio_number': folioNumber,
        'state': state,
        'amount': amount,
        'units': units,
        'switch_out_scheme': switchOutScheme,
        'switch_in_scheme': switchInScheme,
        'plan': plan,
        'switched_out_units': switchedOutUnits,
        'switched_out_amount': switchedOutAmount,
        'switched_out_price': switchedOutPrice,
        'switched_in_units': switchedInUnits,
        'switched_in_amount': switchedInAmount,
        'switched_in_price': switchedInPrice,
        'gateway': gateway,
        'traded_on': tradedOn,
        'scheduled_on': scheduledOn,
        'created_at': createdAt,
        'succeeded_at': succeededAt,
        'submitted_at': submittedAt,
        'reversed_at': reversedAt,
        'failed_at': failedAt,
        'confirmed_at': confirmedAt,
        'source_ref_id': sourceRefId,
        'user_ip': userIp,
        'server_ip': serverIp,
        'initiated_by': initiatedBy,
        'initiated_via': initiatedVia,
        'euin': euin,
        'partner': partner,
        'failure_code': failureCode,
        'updated_at': updatedAt,
        'user_id': userId,
        'transaction_basket_item_id': transactionBasketItemId,
        'user': user,
        'switch_out_fund_name': switchOutFundName,
        'switch_out_logo_url': switchOutLogoUrl,
        'switch_in_fund_name': switchInFundName,
        'switch_in_logo_url': switchInLogoUrl,
      };
}

class SwitchUserModel extends SwitchUserEntity {
  SwitchUserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.mobile,
    required super.role,
    required super.isBulkUploaded,
    required super.bulkUserFileId,
    required super.createdAt,
    required super.updatedAt,
    required super.password,
  });

  factory SwitchUserModel.fromJson(Map<String, dynamic> json) {
    return SwitchUserModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      mobile: json['mobile'],
      role: json['role'],
      isBulkUploaded: json['is_bulk_uploaded'],
      bulkUserFileId: json['bulk_user_file_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      password: null,
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
