import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import '../../../investers/presentation/pages/invester_screen.dart';
import 'home_dash_tab.dart/home_dash_tab.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  PageController? _pageController;

  final List<Widget> _screens = [
    const HomeDashTabScreen(),
    ManageInvestorsPage(),
    const Center(child: Text('Investors Screen')),
    const Center(child: Text('Transactions Screen')),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController!.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          // physics: const BouncingScrollPhysics(),
          physics: const NeverScrollableScrollPhysics(),

          children: _screens,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: _selectedIndex,
          height: 60.0,
          items: <Widget>[
            Icon(
              Icons.dashboard,
              size: 30,
              color: _selectedIndex == 0 ? AppColors.pureWhite : Colors.black,
            ),
            Icon(
              Icons.people,
              size: 30,
              color: _selectedIndex == 1 ? AppColors.pureWhite : Colors.black,
            ),
            Icon(
              Icons.trending_up,
              size: 30,
              color: _selectedIndex == 2 ? AppColors.pureWhite : Colors.black,
            ),
            Icon(
              Icons.swap_horiz,
              size: 30,
              color: _selectedIndex == 3 ? AppColors.pureWhite : Colors.black,
            ),
          ],
          color: Colors.white,
          buttonBackgroundColor: AppColors.primaryColor,
          backgroundColor: AppColors.pureWhite,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: _onItemTapped,
          letIndexChange: (index) => true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
