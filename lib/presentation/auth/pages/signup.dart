import 'package:auto_route/auto_route.dart';
import 'package:clot_store/common/button/basic_app_button.dart';
import 'package:clot_store/presentation/router/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              signInText(context),
              const SizedBox(
                height: 20,
              ),
              firstNameField(context),
              const SizedBox(
                height: 20,
              ),
              secondNameField(context),
              const SizedBox(
                height: 20,
              ),
              emailAddressField(context),
              const SizedBox(
                height: 20,
              ),
              passwordField(context),
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
    ));
  }

  Widget signInText(BuildContext context) {
    return const Text(
      "Create Account",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget firstNameField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "First Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget secondNameField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Last Name  ",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget emailAddressField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Email Address",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget passwordField(BuildContext context) {
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
      const TextSpan(text: "Do you have an account ? "),
      TextSpan(
          text: "Signin",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.pushRoute(const SigninRoute());
            })
    ]));
  }
}
