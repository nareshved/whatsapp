import 'package:flutter/material.dart';

class WhatsAppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const WhatsAppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  WhatsAppTextFieldState createState() => WhatsAppTextFieldState();
}

class WhatsAppTextFieldState extends State<WhatsAppTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   if (_isFocused)
        //     BoxShadow(
        //       color: Colors.black.withOpacity(0.1),
        //       spreadRadius: 1,
        //       blurRadius: 5,
        //       offset: const Offset(0, 2),
        //     ),
        // ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        onEditingComplete: () {
          setState(() {
            _isFocused = false;
          });
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
