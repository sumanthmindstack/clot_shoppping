import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../common/button/basic_app_button.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              signInText(context),
              const SizedBox(
                height: 20,
              ),
              enterEmailAdresssField(context),
              const SizedBox(
                height: 20,
              ),
              continueButton(context),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signInText(BuildContext context) {
    return const Text(
      "Forgot Possword",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget enterEmailAdresssField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Enter Email Address",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {},
      title: "Continue",
    );
  }
}
