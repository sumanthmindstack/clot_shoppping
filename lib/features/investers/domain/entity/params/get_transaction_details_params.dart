import 'package:json_annotation/json_annotation.dart';

part 'get_transaction_details_params.g.dart';

@JsonSerializable()
class GetTransactionDetailsParams {
  @JsonKey(name: 'transaction_basket_item_id')
  final int transactionBasketItemId;

  GetTransactionDetailsParams({
    required this.transactionBasketItemId,
  });

  factory GetTransactionDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetTransactionDetailsParamsToJson(this);
}
