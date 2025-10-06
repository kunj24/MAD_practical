import 'package:flutter/material.dart';

Widget buildTextField(
  TextEditingController controller,
  String placeholder, {
  IconData? icon,
  TextInputType keyboard = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: TextField(
      controller: controller,
      keyboardType: keyboard,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: icon == null
            ? null
            : Icon(icon, color: const Color(0xFF1976D2)),
        filled: true,
        fillColor: const Color(0xFF0B0B0B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

Widget buildMultilineField(
  TextEditingController controller,
  String placeholder,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 6,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: const Color(0xFF0B0B0B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    ),
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

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: const Color(0xFF0B0B0B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
