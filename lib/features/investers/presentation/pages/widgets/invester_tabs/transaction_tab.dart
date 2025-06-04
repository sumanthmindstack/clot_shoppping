import 'package:flutter/material.dart';

import '../../../../../../widgets/custom_tab_view.dart';
import 'transaction_tabs/lumpsum_tab.dart';

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
        const Center(child: Text("SIP")),
        const Center(child: Text("Switch")),
        const Center(child: Text("STP")),
        const Center(child: Text("SWP")),
        const Center(child: Text("Redeem")),
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
