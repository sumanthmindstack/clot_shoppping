import 'package:flutter/material.dart';

class CompanyWeightChart extends StatefulWidget {
  final Map<String, double> companyWeights;
  final String? title;

  const CompanyWeightChart({
    super.key,
    required this.companyWeights,
    this.title,
  });

  @override
  State<CompanyWeightChart> createState() => _CompanyWeightChartState();
}

class _CompanyWeightChartState extends State<CompanyWeightChart> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final companies = widget.companyWeights.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topCompanies = companies.take(14).toList();
    final maxWeight = topCompanies.isNotEmpty ? topCompanies.first.value : 1.0;

    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  widget.title ?? '',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                const Spacer(),
                Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
            const SizedBox(height: 10),
            if (_isExpanded)
              ...topCompanies
                  .map((e) => _companyRow(e.key, e.value, maxWeight)),
          ],
        ),
      ),
    );
  }

  Widget _companyRow(String name, double weight, double max) {
    final progress = weight / max;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Text(name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500))),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
              minHeight: 8,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
              width: 50,
              child: Text('${weight.toStringAsFixed(2)}%',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
