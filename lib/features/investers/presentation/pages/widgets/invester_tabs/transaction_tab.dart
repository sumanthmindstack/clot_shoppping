import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/pages/widgets/invester_tabs/transaction_tabs/stp_tab.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/pages/widgets/invester_tabs/transaction_tabs/swp_tab.dart';

import '../../../../../../widgets/custom_tab_view.dart';
import 'transaction_tabs/lumpsum_tab.dart';
import 'transaction_tabs/redeem_tab.dart';
import 'transaction_tabs/sip_tab.dart';
import 'transaction_tabs/switch_tab.dart';

class TransactionTab extends StatefulWidget {
  final int userId;
  const TransactionTab({super.key, required this.userId});

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  @override
  Widget build(BuildContext context) {
    return CustomTabView(
      tabContents: [
        LumpsumTab(userId: widget.userId),
        SipTab(userId: widget.userId),
        SwitchTab(userId: widget.userId),
        StpTab(userId: widget.userId),
        SwpTab(userId: widget.userId),
        RedeemTab(
          userId: widget.userId,
        ),
      ],
      tabTitles: const [
        "Lumpsum",
        "SIP",
        "Switch",
        "STP",
        "SWP",
        "Redeem",
      ],
    );
  }
}
