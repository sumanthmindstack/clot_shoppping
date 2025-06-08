import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

import '../../../../../../../common/formatters.dart';
import '../../../../../domain/entity/user_goals_entity.dart';

class UserGoalCard extends StatelessWidget {
  final UserGoalEntity data;

  const UserGoalCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          _buildDetailsRow(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            data.goalName,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        data.goalName.isNotEmpty ? data.goalName[0].toUpperCase() : '',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildDetailsRow() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailLabel(text: 'Current Cost'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Current Monthly Expenses'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Retirement Age'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Life Expectancy'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Expected Inflation'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Target Year'),
              SizedBox(height: 8),
              _DetailLabel(text: 'Expected Returns'),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildDetailValue(
                  Formatters().formatAdaptiveUnit(num.parse(data.currentCost))),
              const SizedBox(height: 8),
              _buildDetailValue(Formatters()
                  .formatAdaptiveUnit(num.parse(data.currentMonthlyExpenses))),
              const SizedBox(height: 8),
              _buildDetailValue(data.retirementAge.toString()),
              const SizedBox(height: 8),
              _buildDetailValue("${data.lifeExpectancy.toString()} years"),
              const SizedBox(height: 8),
              _buildDetailValue(
                  '${data.expectedInflation.toStringAsFixed(2)} %'),
              const SizedBox(height: 8),
              _buildDetailValue(data.targetYear.toString()),
              const SizedBox(height: 8),
              _buildDetailValue('${data.expectedReturns.toStringAsFixed(2)} %'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailValue(String value, {bool isHighlighted = false}) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: isHighlighted ? Colors.green.shade700 : Colors.grey.shade900,
      ),
    );
  }
}

class _DetailLabel extends StatelessWidget {
  final String text;

  const _DetailLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade600,
      ),
    );
  }
}
