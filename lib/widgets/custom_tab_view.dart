import 'package:flutter/material.dart';

class CustomTabView extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;

  const CustomTabView({
    super.key,
    required this.tabTitles,
    required this.tabContents,
  }) : assert(tabTitles.length == tabContents.length,
            'Tabs and content length must match');

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(widget.tabTitles.length, (index) {
              final isSelected = _selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      widget.tabTitles[index],
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 50,
            ),
            child: widget.tabContents[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
