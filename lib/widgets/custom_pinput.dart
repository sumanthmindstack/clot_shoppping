import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'package:pinput/pinput.dart';

class CustomPinput extends StatefulWidget {
  final int length;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validateOtp;
  final bool? obscureText;
  final bool autofocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool enableHapticFeedback;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final double boxSize;

  const CustomPinput({
    Key? key,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
    this.validateOtp,
    this.obscureText,
    this.autofocus = true,
    this.controller,
    this.focusNode,
    this.enableHapticFeedback = true,
    this.fillColor,
    this.borderColor,
    this.textStyle,
    this.borderRadius = 12.0,
    this.boxSize = 56.0,
  }) : super(key: key);

  @override
  State<CustomPinput> createState() => _CustomPinputState();
}

class _CustomPinputState extends State<CustomPinput> {
  bool _hasError = false;
  String? _errorText;

  void _handleCompleted(String value) {
    if (value.isEmpty || value.length < widget.length) {
      HapticFeedback.vibrate();
      setState(() {
        _hasError = true;
        _errorText = 'Incomplete OTP';
      });
      return;
    }

    if (widget.validateOtp != null) {
      final error = widget.validateOtp!(value);
      if (error != null) {
        HapticFeedback.vibrate();
        setState(() {
          _hasError = true;
          _errorText = error;
        });
        return;
      }
    }

    setState(() {
      _hasError = false;
      _errorText = null;
    });
    widget.onCompleted?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final baseDecoration = BoxDecoration(
      color: widget.fillColor ?? AppColors.pureWhite,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      border: Border.all(
        color:
            _hasError ? Colors.red : widget.borderColor ?? Colors.grey.shade400,
      ),
    );

    final defaultTheme = PinTheme(
      width: widget.boxSize,
      height: widget.boxSize,
      textStyle: widget.textStyle ??
          const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
      decoration: baseDecoration,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Pinput(
          validator: widget.validateOtp,
          length: widget.length,
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          obscureText: widget.obscureText ?? false,
          hapticFeedbackType: widget.enableHapticFeedback
              ? HapticFeedbackType.mediumImpact
              : HapticFeedbackType.disabled,
          showCursor: true,
          defaultPinTheme: defaultTheme,
          focusedPinTheme: defaultTheme.copyWith(
            decoration: baseDecoration.copyWith(
              border: Border.all(
                color: _hasError ? Colors.red : Colors.blue,
              ),
            ),
          ),
          submittedPinTheme: defaultTheme,
          onCompleted: _handleCompleted,
          onChanged: (value) {
            if (_hasError) {
              setState(() {
                _hasError = false;
                _errorText = null;
              });
            }
            widget.onChanged?.call(value);
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        if (_hasError && _errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              _errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
