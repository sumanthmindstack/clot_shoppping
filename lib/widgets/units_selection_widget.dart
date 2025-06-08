import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class UnitsSelectionWidget extends StatefulWidget {
  final List<String> scales;
  final String? selectedScale;
  final ValueChanged<String> onScaleSelected;

  const UnitsSelectionWidget({
    super.key,
    required this.scales,
    this.selectedScale,
    required this.onScaleSelected,
  });

  @override
  State<UnitsSelectionWidget> createState() => _UnitsSelectionWidgetState();
}

class _UnitsSelectionWidgetState extends State<UnitsSelectionWidget> {
  late String _currentSelected;

  @override
  void initState() {
    super.initState();
    _currentSelected = widget.selectedScale ?? widget.scales.first;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.scales.map((scale) {
          final isSelected = _currentSelected == scale;
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: SizedBox(
              height: 38,
              width: 110,
              child: FilterChip(
                label: Text(
                  scale,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primaryColor,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _currentSelected = scale;
                  });
                  widget.onScaleSelected(scale);
                },
                selectedColor: AppColors.primaryColor,
                backgroundColor: AppColors.pureWhite,
                checkmarkColor: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: isSelected
                        ? Colors.transparent
                        : AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
