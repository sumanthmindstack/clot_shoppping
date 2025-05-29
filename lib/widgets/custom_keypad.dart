import 'package:flutter/material.dart';

class CustomKeypad extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String value) onCompleted;

  const CustomKeypad({
    super.key,
    required this.controller,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    List<String> keys = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '.',
      '0',
      '⌫'
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            if (key == '⌫') {
              if (controller.text.isNotEmpty) {
                controller.text =
                    controller.text.substring(0, controller.text.length - 1);
              }
            } else if (controller.text.length < 4 && key != '.') {
              controller.text += key;
              if (controller.text.length == 4) {
                onCompleted(controller.text);
              }
            }
          },
          child: Text(
            key,
            style: const TextStyle(color: Colors.black, fontSize: 24),
          ),
        );
      },
    );
  }
}
