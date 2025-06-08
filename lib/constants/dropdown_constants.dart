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
  final List<DropdownConfig> traansactionSipFilterDropdowns = [
    DropdownConfig('Select Filter', [
      'Select Filter',
      'Active',
      'Confirmed',
      'Created',
      'Completed',
      'Successful',
      'Failed',
      'Cancelled',
      'Paused',
    ]),
  ];
  final List<DropdownConfig> traansactionLumpsumFilterDropdowns = [
    DropdownConfig('Select Filter', [
      'Select Filter',
      'Pending',
      'Confirmed',
      'Created',
      'Submitted',
      'Successful',
      'Failed',
      'Cancelled',
      'Reversed',
    ]),
  ];
  final List<DropdownConfig> traansactionSwitchFilterDropdowns = [
    DropdownConfig('Select Filter', [
      'Select Filter',
      'Active',
      'Confirmed',
      'Created',
      'Completed',
      'Successful',
      'Failed',
      'Cancelled',
    ]),
  ];
  final List<DropdownConfig> traansactionStpFilterDropdowns = [
    DropdownConfig('Select Filter', [
      'Select Filter',
      'Active',
      'Confirmed',
      'Created',
      'Completed',
      'Successful',
      'Failed',
      'Cancelled',
    ]),
  ];
  final List<DropdownConfig> traansactionSwpFilterDropdowns = [
    DropdownConfig('Select Filter', [
      'Select Filter',
      'Active',
      'Confirmed',
      'Created',
      'Completed',
      'Successful',
      'Failed',
      'Cancelled',
    ]),
  ];
  final List<DropdownConfig> traansactionRedeemFilterDropdowns = [
    DropdownConfig('Select Filter', [
      'Select Filter',
      'Active',
      'Confirmed',
      'Created',
      'Completed',
      'Successful',
      'Failed',
      'Cancelled',
    ]),
  ];
}
