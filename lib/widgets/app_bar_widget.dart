import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget> actions;
  final Widget? leading;
  final Color backgroundColor;
  final bool automaticallyImplyLeading;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions = const [],
    this.leading,
    this.backgroundColor = AppColors.pureWhite,
    this.automaticallyImplyLeading = true,
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
