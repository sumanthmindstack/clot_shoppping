import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/widgets/app_bar_widget.dart';
import 'package:maxwealth_distributor_app/widgets/custom_snackbar.dart';
import 'package:maxwealth_distributor_app/widgets/submit_button_widget.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/animate_page_widget.dart';

@RoutePage()
class DistributorAgreementPage extends StatefulWidget {
  const DistributorAgreementPage({super.key});

  @override
  State<DistributorAgreementPage> createState() =>
      _DistributorAgreementPageState();
}

class _DistributorAgreementPageState extends State<DistributorAgreementPage> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return AnimatePageWidget(
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(automaticallyImplyLeading: true),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _headerText(),
                      const SizedBox(height: 16),
                      _descriptionText(),
                      const SizedBox(height: 24),
                      _agreementBox(),
                      const SizedBox(height: 16),
                      _acknowledgmentText(),
                      const SizedBox(height: 20),
                      _radioButtons(),
                      const SizedBox(height: 30),
                      _submitButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerText() {
    return const Center(
      child: Text(
        "Distributor Agreement",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _descriptionText() {
    return const Center(
      child: Text(
        "The Distributor Agreement references the Torus Terms and Conditions which can be found here.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _agreementBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'I have read the '),
            TextSpan(
                text: 'Terms and Conditions ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '("the SO Terms"), the '),
            TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ', and these '),
            TextSpan(
                text: 'Disclaimers & Disclosures',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    ', and understand that these documents govern my use of services and this platform.'),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _acknowledgmentText() {
    return const Text(
      'By clicking the "agree" button below I acknowledge that I understand and agree to the above.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14),
    );
  }

  Widget _radioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<String>(
          fillColor: const WidgetStatePropertyAll(AppColors.primaryColor),
          activeColor: AppColors.primaryColor,
          focusColor: AppColors.primaryColor,
          value: 'Agree',
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value),
        ),
        const Text('Agree'),
        const SizedBox(width: 20),
        Radio<String>(
          fillColor: const WidgetStatePropertyAll(AppColors.primaryColor),
          activeColor: AppColors.primaryColor,
          focusColor: AppColors.primaryColor,
          value: 'Decline',
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value),
        ),
        const Text('Decline'),
      ],
    );
  }

  Widget _submitButton() {
    return SubmitButtonWidget(
      label: "Submit",
      onPressed: () {
        AutoRouter.of(context).push(const UnderReviewRoute());
        if (_selectedOption == 'Agree') {
          CustomSnackBar.show(
            context,
            message: "Agreement Accepted",
            backgroundColor: AppColors.primaryColor,
          );
        }

        Future.delayed(const Duration(seconds: 6), () {
          // AutoRouter.of(context).replaceAll([const LoginRoute()]);
          AutoRouter.of(context).popUntilRoot();
        });
      },
      color: AppColors.primaryColor,
    );
  }
}
