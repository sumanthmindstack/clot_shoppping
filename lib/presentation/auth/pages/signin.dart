import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../common/button/basic_app_button.dart';
import '../../router/app_router.dart';

@RoutePage()
class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            signInText(context),
            const SizedBox(
              height: 20,
            ),
            emailAddressField(context),
            const SizedBox(
              height: 20,
            ),
            continueButton(context),
            const SizedBox(
              height: 20,
            ),
            dontHaveAnAccount(context),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  Widget signInText(BuildContext context) {
    return const Text(
      "Sign In",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget emailAddressField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Email Address",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {},
      title: "Continue",
    );
  }

  Widget dontHaveAnAccount(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(text: "Don't have an account ? "),
      TextSpan(
          text: "Create one",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.pushRoute(const SignUpRoute());
            })
    ]));
  }
}
