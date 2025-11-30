import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller, this.onChanged});
final TextEditingController controller;
final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(CupertinoIcons.search),
          hintText: 'Search..',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
