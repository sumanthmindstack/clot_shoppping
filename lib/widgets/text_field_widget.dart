import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
  final String labelText;
  final String? Function(String?) validator;
  final FormFieldSetter<String?>? onSaved;
  final String? hintText;
  final TextInputType? isNumberOrString;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? textInputFormat;
  final TextEditingController controller;
  final TextCapitalization? textCapitalization;

  const TextFieldWidget({
    super.key,
    required this.labelText,
    required this.validator,
    this.onSaved,
    this.hintText,
    required this.isNumberOrString,
    required this.onChanged,
    required this.textInputFormat,
    required this.controller,
    this.textCapitalization,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });

    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: widget.isNumberOrString,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        TitleCaseTextFormatter(),
        ...?widget.textInputFormat,
      ],
      onChanged: widget.onChanged,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onFieldSubmitted: (_) => _focusNode.unfocus(),
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: AppColors.hintText),
        hintText: widget.hintText,
        labelText: widget.labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(color: Colors.black),
        prefixStyle: const TextStyle(fontSize: 12, color: Colors.black),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 12),
    );
  }
}

class TitleCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    final formatted = text
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.length > 1 ? word.substring(1) : ''}'
            : '')
        .join(' ');

    return newValue.copyWith(
      text: formatted,
      selection: newValue.selection,
    );
  }
}
