import 'package:flutter/material.dart';

// Beginner-friendly app theme helpers.
// Change colors or radii here and all screens update together.
class AppTheme {
  static const Color primary = Color(0xFF273645);
  static const Color emphasis = Color(0xFF000000);
  static const Color card = Color(0xFFF5F6F7);
  static const double cornerRadius = 12;
  static const EdgeInsets pagePadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 16);

  static TextStyle titleLarge(BuildContext context) => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      );

  static OutlineInputBorder inputBorder(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(cornerRadius),
        borderSide: BorderSide(color: color),
      );
}

