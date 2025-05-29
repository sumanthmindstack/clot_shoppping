import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;
  final String hintText;
  final void Function(DateTime?) onDatePicked;
  final String? validationMessage;
  final FormFieldValidator<DateTime>? validator;
  final DateTime? initialDate;

  const CustomDatePicker({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onDatePicked,
    this.validationMessage,
    this.validator,
    this.initialDate,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      validator: (value) {
        if (value == null) {
          return widget.validationMessage ?? "Please select a date";
        }
        return null;
      },
      initialValue: widget.initialDate,
      builder: (FormFieldState<DateTime> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                FocusScope.of(context)
                    .requestFocus(_focusNode); // Request focus
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: state.value ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  state.didChange(pickedDate);
                  widget.onDatePicked(pickedDate);
                  Form.of(context)?.validate();
                }

                // Remove focus after date is picked
                Future.delayed(Duration(milliseconds: 100), () {
                  _focusNode.unfocus();
                });
              },
              child: Focus(
                focusNode: _focusNode,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: widget.labelText,
                    hintText: widget.hintText,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Change this color as needed
                        width: 2,
                      ),
                    ),
                    errorText: state.errorText,
                  ),
                  isFocused: _isFocused,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.value != null
                            ? "${state.value!.day}/${state.value!.month}/${state.value!.year}"
                            : widget.hintText,
                        style: TextStyle(
                          color: state.value != null
                              ? Colors.black
                              : Colors.grey.shade600,
                        ),
                      ),
                      const Icon(Icons.calendar_today_outlined,
                          color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
