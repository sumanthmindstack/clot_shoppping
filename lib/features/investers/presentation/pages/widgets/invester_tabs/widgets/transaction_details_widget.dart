import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxwealth_distributor_app/common/formatters.dart';
import 'package:maxwealth_distributor_app/gen/assets.gen.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../domain/entity/get_transaction_details_entity.dart';
import '../../../../bloc/get_transaction_details.dart/get_transaction_details_cubit.dart';

class TransactionDetailsWidget extends StatefulWidget {
  final int transactionBasketItemId;

  const TransactionDetailsWidget({
    super.key,
    required this.transactionBasketItemId,
  });

  @override
  State<TransactionDetailsWidget> createState() =>
      _TransactionDetailsWidgetState();
}

class _TransactionDetailsWidgetState extends State<TransactionDetailsWidget> {
  @override
  void initState() {
    _intialApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: BlocConsumer<GetTransactionDetailsCubit,
            GetTransactionDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetTransactionDetailsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            if (state is GetTransactionDetailsSuccessState) {
              final data = state.transactionDetailsEntity;

              return Column(
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 16),
                  _buildTransactionInfo(data),
                  const SizedBox(height: 16),
                  _buildFundDetailsCard(context, data),
                  const SizedBox(height: 16),
                  _buildOrderStatus(data),
                ],
              );
            }

            return const Center(
              child: Text("No Transaction Data"),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Transaction Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionInfo(GetTransactionDetailsEntity data) {
    return Column(
      children: [
        Formatters().getStatusIcon(data.orderDetails.status),
        const SizedBox(height: 8),
        Text(
          'Lumpsum Order Has Been ${Formatters().capitalizeWords(data.orderDetails.status)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text('Amount: ₹${data.orderDetails.amount}',
            style: const TextStyle(fontSize: 15)),
        Text('Units: ${data.orderDetails.units}',
            style: const TextStyle(fontSize: 15)),
      ],
    );
  }

  Widget _buildFundDetailsCard(
      BuildContext context, GetTransactionDetailsEntity data) {
    final fund = data.fundDetails[0];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: fund.amc.logoUrl,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Formatters().capitalizeWords(fund.basicName),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${Formatters().capitalizeWords(fund.planName)} '
                        '${Formatters().capitalizeWords(fund.category.categoryName)}',
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _FundDetailTile(
                title: 'ISIN Code', value: data.orderDetails.fundIsin),
            _FundDetailTile(
              title:
                  'Cr. Nav\n(${Formatters().formatIsoToReadableDate(fund.navDate.toString())})',
              value: '₹5101.26',
            ),
            _FundDetailTile(
              title: 'Order Date',
              value: Formatters().formatIsoToReadableDate(
                  data.orderDetails.createdAt.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatus(GetTransactionDetailsEntity data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Status',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
                  const SizedBox(height: 4),
                  Icon(Icons.more_vert,
                      color: Formatters()
                          .getVertialMoreIconColor(data.orderDetails.status),
                      size: 24),
                  Formatters().getVerticalMoreIcon(data.orderDetails.status)
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Placed on MfWealth',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      Formatters().formatIsoToReadableDate(
                          data.orderDetails.createdAt.toString()),
                      style: const TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Payment ${data.orderDetails.status}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _intialApiCall() {
    context.read<GetTransactionDetailsCubit>().fetchTransactionDetails(
        transactionBasketItemId: widget.transactionBasketItemId);
  }
}

class _FundDetailTile extends StatelessWidget {
  final String title;
  final String value;

  const _FundDetailTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
