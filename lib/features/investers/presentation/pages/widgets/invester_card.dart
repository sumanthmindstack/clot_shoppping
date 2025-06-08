import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/formatters.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/get_invester_list_entitty.dart';

import '../../../../../themes/app_colors.dart';
import '../../bloc/get_invester_list/get_invester_list_cubit.dart';

class InvestorCard extends StatefulWidget {
  final InvestorEntity data;
  final VoidCallback onTap;

  const InvestorCard({
    required this.data,
    required this.onTap,
    super.key,
  });

  @override
  State<InvestorCard> createState() => _InvestorCardState();
}

class _InvestorCardState extends State<InvestorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardBoxDecoration,
      child: BlocConsumer<GetInvesterListCubit, GetInvesterListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildHeader(),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  _buildFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    final String status = widget.data.fpKycStatus;
    final Color statusColor = Formatters().getStatusColor(status);

    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.black20,
          child: Icon(
            Icons.person,
            size: 35,
            color: AppColors.pureWhite,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.user.fullName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "(As per PAN:${widget.data.fullName})",
                style: const TextStyle(
                    fontSize: 14, color: AppColors.secondaryGrey),
              ),
              const SizedBox(height: 2),
              Text(
                widget.data.user.email,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        _buildStatusBadge(status, statusColor),
      ],
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        Formatters().getStatusLabel(status),
        style: const TextStyle(
          color: AppColors.pureWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _InfoItem(icon: Icons.phone, text: widget.data.user.mobile),
            _InfoItem(icon: Icons.credit_card, text: widget.data.pan),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _InfoItem(
                icon: Icons.calendar_today,
                text: Formatters()
                    .formatIsoToReadableDate(widget.data.createdAt)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.18,
            ),
            _buildActionButton(),
          ],
        ),
        _InfoItem(
            icon: Icons.fingerprint,
            text: "XXXX-XXXX-${widget.data.aadhaarNo ?? "----"}"),
      ],
    );
  }

  Widget _buildActionButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        color: AppColors.borderGrey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: const Text(
        "Action",
        style: TextStyle(color: AppColors.black20),
      ),
    );
  }

  BoxDecoration get _cardBoxDecoration => BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      );
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
