import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Silk Serif is bundled via [pubspec.yaml]. Poppins loads through [GoogleFonts].
abstract final class AppFonts {
  static const String silkSerifFamily = 'SilkSerif';

  static TextStyle silkSerif({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: silkSerifFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle poppins({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Poppins 16px, weight medium (500) — Services category block titles & Latest Offer.
  static TextStyle servicesCategoryTitle({Color? color}) {
    return poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color ?? const Color(0xFF3D3530),
      height: 1.2,
    );
  }
}
