// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transaction_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTransactionDetailsParams _$GetTransactionDetailsParamsFromJson(
        Map<String, dynamic> json) =>
    GetTransactionDetailsParams(
      transactionBasketItemId:
          (json['transaction_basket_item_id'] as num).toInt(),
    );

Map<String, dynamic> _$GetTransactionDetailsParamsToJson(
        GetTransactionDetailsParams instance) =>
    <String, dynamic>{
      'transaction_basket_item_id': instance.transactionBasketItemId,
    };
