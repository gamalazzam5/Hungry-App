import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({super.key, required this.controller, required this.labelText});
final TextEditingController controller;
final String labelText;
  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      cursorColor: Colors.white,
      cursorHeight: 20,
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
