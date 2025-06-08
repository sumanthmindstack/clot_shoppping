import 'package:equatable/equatable.dart';

class GetSwpDataEntity extends Equatable {
  final List<SwpDataEntity>? data;
  final MetaEntity? meta;

  const GetSwpDataEntity({
    this.data,
    this.meta,
  });

  @override
  List<Object?> get props => [data, meta];
}

class SwpDataEntity extends Equatable {
  final dynamic id;
  final String? state;
  final bool? systematic;
  final String? mfInvestmentAccount;
  final String? folioNumber;
  final String? frequency;
  final String? scheme;
  final int? installmentDay;
  final String? startDate;
  final String? endDate;
  final int? numberOfInstallments;
  final bool? autoGenerateInstallments;
  final String? nextInstallmentDate;
  final String? previousInstallmentDate;
  final int? remainingInstallments;
  final String? amount;
  final String? sourceRefId;
  final String? euin;
  final String? partner;
  final String? createdAt;
  final String? activatedAt;
  final String? requestedActivationDate;
  final String? cancelledAt;
  final String? completedAt;
  final String? failedAt;
  final String? cancellationScheduledOn;
  final String? gateway;
  final String? userIp;
  final String? serverIp;
  final String? initiatedBy;
  final String? initiatedVia;
  final String? reason;
  final int? userId;
  final int? transactionBasketItemId;
  final String? updatedAt;
  final SwpUserEntity? user;
  final String? fundName;
  final String? logoUrl;

  const SwpDataEntity({
    this.id,
    this.state,
    this.systematic,
    this.mfInvestmentAccount,
    this.folioNumber,
    this.frequency,
    this.scheme,
    this.installmentDay,
    this.startDate,
    this.endDate,
    this.numberOfInstallments,
    this.autoGenerateInstallments,
    this.nextInstallmentDate,
    this.previousInstallmentDate,
    this.remainingInstallments,
    this.amount,
    this.sourceRefId,
    this.euin,
    this.partner,
    this.createdAt,
    this.activatedAt,
    this.requestedActivationDate,
    this.cancelledAt,
    this.completedAt,
    this.failedAt,
    this.cancellationScheduledOn,
    this.gateway,
    this.userIp,
    this.serverIp,
    this.initiatedBy,
    this.initiatedVia,
    this.reason,
    this.userId,
    this.transactionBasketItemId,
    this.updatedAt,
    this.user,
    this.fundName,
    this.logoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        state,
        systematic,
        mfInvestmentAccount,
        folioNumber,
        frequency,
        scheme,
        installmentDay,
        startDate,
        endDate,
        numberOfInstallments,
        autoGenerateInstallments,
        nextInstallmentDate,
        previousInstallmentDate,
        remainingInstallments,
        amount,
        sourceRefId,
        euin,
        partner,
        createdAt,
        activatedAt,
        requestedActivationDate,
        cancelledAt,
        completedAt,
        failedAt,
        cancellationScheduledOn,
        gateway,
        userIp,
        serverIp,
        initiatedBy,
        initiatedVia,
        reason,
        userId,
        transactionBasketItemId,
        updatedAt,
        user,
        fundName,
        logoUrl,
      ];
}

class SwpUserEntity extends Equatable {
  final int? id;
  final String? fullName;
  final String? email;
  final String? mobile;
  final String? role;
  final bool? isBulkUploaded;
  final int? bulkUserFileId;
  final String? createdAt;
  final String? updatedAt;

  const SwpUserEntity({
    this.id,
    this.fullName,
    this.email,
    this.mobile,
    this.role,
    this.isBulkUploaded,
    this.bulkUserFileId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        mobile,
        role,
        isBulkUploaded,
        bulkUserFileId,
        createdAt,
        updatedAt,
      ];
}

class MetaEntity extends Equatable {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  const MetaEntity({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  @override
  List<Object?> get props => [page, limit, total, totalPages];
}
