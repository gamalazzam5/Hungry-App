import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({super.key, required this.controller, required this.labelText, this.keyboardType});
final TextEditingController controller;
final String labelText;
final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return  TextField(

      controller: controller,
      cursorColor: Colors.white,
      cursorHeight: 20,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(16)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(16)

        ),
      ),
    );
  }
}
