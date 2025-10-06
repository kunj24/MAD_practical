import 'package:flutter/material.dart';

Widget buildTextField(
  TextEditingController controller,
  String placeholder, {
  IconData? icon,
  TextInputType keyboard = TextInputType.text,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboard,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: placeholder,
      prefixIcon: icon == null ? null : Icon(icon, color: Colors.amber[300]),
    ),
  );
}

Widget buildMultilineField(TextEditingController controller, String placeholder) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.multiline,
    minLines: 3,
    maxLines: 6,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(hintText: placeholder),
  );
}

Widget smallTextField({
  required String initial,
  required String placeholder,
  required Function(String) onChanged,
}) {
  final controller = TextEditingController(text: initial);
  controller.addListener(() {
    if (controller.text != initial) {
      onChanged(controller.text);
    }
  });

  return TextField(
    controller: controller,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(hintText: placeholder),
  );
}
