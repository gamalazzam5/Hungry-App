import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;

  // final EdgeInsetsGeometry? contentPadding;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.keyboardType,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.fillColor = Colors.white,
    this.borderColor,
    this.borderRadius = 12,
    // this.contentPadding,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primary,
      cursorHeight: 20,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      validator: (v) {
        if (v == null || v.trim().isEmpty) {
          return 'please fill ${widget.hintText}';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _togglePassword,
                child: Icon(
                  _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,color: AppColors.primary,
                ),
              )
            : widget.suffixIcon,
        hintText: widget.hintText,
        hintStyle: Styles.textStyle16.copyWith(color: AppColors.primary),
        filled: widget.fillColor != null,
        fillColor: Colors.transparent,
        // contentPadding: contentPadding ??
        //     EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: widget.borderColor ?? AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: widget.borderColor ?? AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
