import 'package:flutter/material.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';

class TextFieldOutLine extends StatelessWidget {
  const TextFieldOutLine({
    super.key,
    required this.hintText,
    required this.controller,
    this.isEnable = true,
    required this.prefixIcon,
    this.height = 50,
    this.maxLines = 1,
    this.keyboardType = TextFieldType.normal,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isEnable;
  final Icon prefixIcon;
  final double height;
  final int maxLines;
  final TextFieldType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnable,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType == TextFieldType.number
          ? TextInputType.number
          : keyboardType == TextFieldType.email
              ? TextInputType.emailAddress
              : keyboardType == TextFieldType.multiline
                  ? TextInputType.multiline
                  : TextInputType.text,
      strutStyle: StrutStyle(height: 1.5),
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: hintText,
        labelStyle: TextStyle(
            color: Colors.black,
            fontSize: ResponsiveSingleton.proportionalFont(17)),
        fillColor: Colors.deepPurple.withOpacity(0.1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

enum TextFieldType { normal, password, email, number, multiline }
