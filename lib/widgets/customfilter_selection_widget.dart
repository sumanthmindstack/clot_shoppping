import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'custom_dropdown_field.dart';

class CustomFilterSelectionWidget extends StatefulWidget {
  final List<DropdownConfig> filterConfigs;
  final double itemWidth;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final void Function(String selectedOption)? onOptionSelected;

  const CustomFilterSelectionWidget({
    super.key,
    required this.filterConfigs,
    this.itemWidth = 110,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    this.backgroundColor = AppColors.backgroundGrey,
    this.onOptionSelected,
  });

  @override
  State<CustomFilterSelectionWidget> createState() =>
      _CustomFilterSelectionWidgetState();
}

class _CustomFilterSelectionWidgetState
    extends State<CustomFilterSelectionWidget> {
  String? selectedOption;
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    if (widget.filterConfigs.isNotEmpty &&
        widget.filterConfigs.first.items.isNotEmpty) {
      selectedOption = widget.filterConfigs.first.items.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: widget.padding,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.filter_list, color: AppColors.primaryColor),
                      SizedBox(width: 8),
                      Text(
                        'Filters',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_showFilters)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: widget.padding,
            child: Row(
              children: widget.filterConfigs
                  .expand(
                    (config) => config.items.map(
                      (option) {
                        final isSelected = option == selectedOption;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOption = option;
                              });
                              widget.onOptionSelected?.call(option);
                            },
                            child: Container(
                              width: widget.itemWidth,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                border: isSelected
                                    ? null
                                    : Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1.5,
                                      ),
                              ),
                              child: Center(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
