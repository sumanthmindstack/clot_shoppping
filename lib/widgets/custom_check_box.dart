import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class CustomCheckBox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final String title;

  const CustomCheckBox({
    super.key,
    this.initialValue = false,
    required this.onChanged,
    required this.title,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialValue;
  }

  void _toggleCheckbox() {
    setState(() {
      _checked = !_checked;
    });
    widget.onChanged(_checked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckbox,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: _checked ? AppColors.primaryColor : AppColors.borderGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: _checked
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
