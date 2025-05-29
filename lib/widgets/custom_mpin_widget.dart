import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maxwealth_distributor_app/config/routes/app_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomMpinWidget extends StatefulWidget {
  final TextEditingController controller;

  const CustomMpinWidget({
    super.key,
    required this.controller,
  });

  @override
  State<CustomMpinWidget> createState() => _CustomMpinWidgetState();
}

class _CustomMpinWidgetState extends State<CustomMpinWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validateAndNavigate(String value) {
    if (_formKey.currentState?.validate() ?? false) {
      context.replaceRoute(const DashboardRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Form(
        key: _formKey,
        child: PinCodeTextField(
          appContext: context,
          length: 4,
          obscureText: true,
          obscuringCharacter: '*',
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(12),
            fieldHeight: 60,
            fieldWidth: 60,
            activeColor: Colors.blue,
            inactiveColor: Colors.black26,
            selectedColor: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          controller: widget.controller,
          onCompleted: _validateAndNavigate,
          onChanged: (_) {},
          enableActiveFill: false,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'MPIN is required';
            } else if (value != '1111') {
              return 'Incorrect MPIN';
            }
            return null;
          },
        ),
      ),
    );
  }
}
