import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final bool readyOnly;
  final bool autofocus;
  final Widget? suffix;
  final Widget? prefix;
  final Function(String? value)? validator;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? initialValue;
  final int? maxLines;
  final double borderRadius;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;

  const TextFieldWidget({
    super.key,
    this.initialValue,
    this.controller,
    this.onTap,
    this.readyOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.suffix,
    this.prefix,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines = 1,
    this.borderRadius = 12.0,
    this.contentPadding,
    required this.text,
    this.textCapitalization = TextCapitalization.words,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: maxLines,
        initialValue: initialValue,
        autocorrect: false,
        obscureText: obscureText,
        autofocus: autofocus,
        readOnly: readyOnly,
        textCapitalization: textCapitalization,
        style: const TextStyle(fontSize: 18, color: Colors.black),
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          suffixIcon: suffix,
          prefixIcon: prefix,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          errorStyle: const TextStyle(fontSize: 10, height: 0.1),
          labelText: text,
          labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w300),
        ),
        controller: controller,
        onTap: onTap,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          } else {
            return null;
          }
        });
  }
}
