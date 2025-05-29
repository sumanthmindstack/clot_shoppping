import '../widgets/custom_dropdown_field.dart';

class DropdownConstants {
  final List<DropdownConfig> dropdowns = [
    DropdownConfig('Account Types', [
      'Savings Account',
      'Current Account',
      'Fixed Deposit Account',
      'Recurring Deposit Account',
      'NRI Account',
      'Salary Account',
      'Demat Account',
      'Minor Account',
      'Senior Citizen Account',
      'Joint Account',
    ]),
  ];
  final List<DropdownConfig> years = [
    DropdownConfig('Account Types', [
      '2025',
      '2024',
      '2023',
      '2022',
      '2021',
    ]),
  ];
}
