import 'package:auto_route/auto_route.dart';
import 'package:clot_store/presentation/router/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/button/basic_app_button.dart';

@RoutePage()
class EnterPassWordScreen extends StatelessWidget {
  const EnterPassWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              signInText(context),
              const SizedBox(
                height: 20,
              ),
              enterpasswordField(context),
              const SizedBox(
                height: 20,
              ),
              continueButton(context),
              const SizedBox(
                height: 20,
              ),
              forgotPosswordFiled(context),
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
      "Sign in",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget enterpasswordField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {},
      title: "Continue",
    );
  }

  Widget forgotPosswordFiled(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(text: "Forgot Possword ? "),
      TextSpan(
          text: "Reset",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.pushRoute(const ForgotPasswordRoute());
            })
    ]));
  }
}
