import 'package:flutter/material.dart';

class BTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final IconData prefixIcon;
  const BTextFormField(
      {super.key,
      required this.textEditingController,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 6),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.white),
      ),
    );
  }
}
