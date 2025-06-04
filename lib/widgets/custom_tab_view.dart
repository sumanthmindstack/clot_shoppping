import 'package:flutter/material.dart';

class CustomTabView extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;
  final double? height;

  const CustomTabView({
    super.key,
    required this.tabTitles,
    required this.tabContents,
    this.height,
  }) : assert(tabTitles.length == tabContents.length,
            'Tabs and content length must match');

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  int _selectedIndex = 0;
  final ScrollController _tabScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.height ?? 300,
        maxHeight: widget.height ?? double.infinity,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
            child: SingleChildScrollView(
              controller: _tabScrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(widget.tabTitles.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedIndex = index);
                      _scrollToSelectedTab(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color:
                                isSelected ? Colors.blue : Colors.transparent,
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
                  );
                }),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: widget.tabContents[_selectedIndex],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToSelectedTab(int index) {
    const double itemWidth = 100;
    final double centerPosition = index * itemWidth -
        (_tabScrollController.position.viewportDimension / 2) +
        (itemWidth / 2);
    _tabScrollController.animateTo(
      centerPosition.clamp(0.0, _tabScrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _tabScrollController.dispose();
    super.dispose();
  }
}
