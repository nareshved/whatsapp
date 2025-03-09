import 'package:flutter/material.dart';

Widget myTextField(
    {required String hinttxt,
    Icon? preIcon,
    Widget? suffIcon,
    String? labelTxt,
    required TextEditingController mcrontroller,
    String? Function(String? value)? validator}) {
  return TextFormField(
    validator: validator,
    controller: mcrontroller,
    decoration: InputDecoration(
      label: Text(labelTxt!),
      prefixIcon: preIcon,
      suffixIcon: suffIcon,
      border: const OutlineInputBorder(),
      hintText: hinttxt,
    ),
  );
}
