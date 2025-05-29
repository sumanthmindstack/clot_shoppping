import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:auto_route/auto_route.dart';
import '../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import 'package:maxwealth_distributor_app/constants/meta_strings.dart';

import '../../widgets/animate_page_widget.dart';

@RoutePage()
class Walkthrough1Page extends StatefulWidget {
  const Walkthrough1Page({super.key});

  @override
  State<Walkthrough1Page> createState() => _Walkthrough1PageState();
}

class _Walkthrough1PageState extends State<Walkthrough1Page> {
  final PageController _controller = PageController();
  late Timer _autoScrollTimer;
  int _currentPage = 0;

  final List<String> _headers = [
    WalkThroughStrings.walkThrough1Header,
    WalkThroughStrings.walkThrough2Header,
  ];

  final List<String> _contents = [
    WalkThroughStrings.walkThrough1Content,
    WalkThroughStrings.walkThrough2Content,
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_controller.hasClients) {
        _currentPage = (_currentPage + 1) % _headers.length;
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBlack,
      body: SafeArea(
        child: AnimatePageWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      _buildWalkthroughImage(),
                      const SizedBox(height: 10),
                      _buildWalkthroughText(),
                      const SizedBox(height: 60),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: _headers.length,
                        effect: const WormEffect(
                          dotHeight: 8,
                          dotWidth: 40,
                          activeDotColor: AppColors.scaffoldBackgroundColor,
                          dotColor: AppColors.mainBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWalkthroughImage() {
    return SvgPicture.asset(Assets.images.wallkthroughImage.path);
  }

  Widget _buildWalkthroughText() {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: _controller,
        itemCount: _headers.length,
        onPageChanged: (index) {
          _currentPage = index;
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(
                _headers[index],
                style: const TextStyle(
                  color: AppColors.scaffoldBackgroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _contents[index],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.scaffoldBackgroundColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
