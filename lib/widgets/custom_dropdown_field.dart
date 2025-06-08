import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class CustomDropdownField extends StatefulWidget {
  final List<DropdownConfig> dropdowns;
  final ValueChanged<Map<int, String?>> onSelectionChanged;

  const CustomDropdownField({
    super.key,
    required this.dropdowns,
    required this.onSelectionChanged,
  });

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final Map<int, String?> selectedValues = {};
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      for (int i = 0; i < widget.dropdowns.length; i++) {
        final items = widget.dropdowns[i].items;
        if (items.isNotEmpty && selectedValues[i] == null) {
          selectedValues[i] = items.first;
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onSelectionChanged(selectedValues);
      });
      _initialized = true;
    }
  }

  Widget _buildDropdownField(int index, DropdownConfig config) {
    return SizedBox(
      height: 46,
      child: DropdownButtonFormField2<String>(
        decoration: InputDecoration(
          labelText: config.label,
          labelStyle: const TextStyle(color: Colors.black),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: 2),
          ),
        ),
        isExpanded: true,
        hint: Text(
          'Select ${config.label}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryColor,
          ),
          iconSize: 24,
        ),
        buttonStyleData: const ButtonStyleData(
          height: 50,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
        ),
        items: config.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValues[index],
        onChanged: (value) {
          selectedValues[index] = value;
          widget.onSelectionChanged(selectedValues);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.dropdowns.asMap().entries.map((entry) {
        final index = entry.key;
        final config = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildDropdownField(index, config),
        );
      }).toList(),
    );
  }
}

class DropdownConfig {
  final String label;
  final List<String> items;

  DropdownConfig(this.label, this.items);
}
