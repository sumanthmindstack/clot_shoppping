import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../gen/assets.gen.dart';

@RoutePage()
class UnderReviewScreen extends StatelessWidget {
  const UnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _underReviewImage(context),
              const SizedBox(height: 24),
              _underReviewText(context),
              const SizedBox(height: 16),
              _underReviewTextContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _underReviewImage(BuildContext context) {
    return Lottie.asset(
      Assets.images.accountVerfied,
      width: 200,
      height: 200,
      repeat: true,
      animate: true,
    );
  }

  Widget _underReviewText(BuildContext context) {
    return const Text(
      'Account is under review.',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _underReviewTextContent(BuildContext context) {
    return const Text(
      'We will get back to you soon',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
