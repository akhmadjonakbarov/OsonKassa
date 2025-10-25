// app_typography.dart
// Jetpack Compose–style Typography for Flutter (Material 3)
// Maps Material 3 (Compose) text roles to Flutter's TextTheme with sane defaults.
// Copy this file into your project and wire it into ThemeData as shown below.

import 'package:flutter/material.dart';

class AppTextStyle {
  /// Replace with your preferred font.
  static const String fontFamily = 'Inter';

  /// Material 3/Compose style map.
  /// Sizes, line-heights and letter-spacing follow M3 defaults.
  static TextTheme textTheme(BuildContext context,
      {Color? color = Colors.black}) {
    // If you want dynamic type scaling beyond textScaleFactor, you can
    // multiply the base sizes here based on MediaQuery.of(context).size.

    return TextTheme(
      // Display
      displayLarge: _style(
        size: 57,
        height: 64,
        weight: FontWeight.w400,
        letterSpacing: -0.25,
        color: color,
      ),
      displayMedium: _style(
        size: 45,
        height: 52,
        weight: FontWeight.w400,
        letterSpacing: 0,
        color: color,
      ),
      displaySmall: _style(
        size: 36,
        height: 44,
        weight: FontWeight.w400,
        letterSpacing: 0,
        color: color,
      ),

      // Headline
      headlineLarge: _style(
        size: 32,
        height: 40,
        weight: FontWeight.w400,
        letterSpacing: 0,
        color: color,
      ),
      headlineMedium: _style(
        size: 28,
        height: 36,
        weight: FontWeight.w400,
        letterSpacing: 0,
        color: color,
      ),
      headlineSmall: _style(
        size: 24,
        height: 32,
        weight: FontWeight.w400,
        letterSpacing: 0,
        color: color,
      ),

      // Title
      titleLarge: _style(
        size: 22,
        height: 28,
        weight: FontWeight.w500,
        letterSpacing: 0,
        color: color,
      ),
      titleMedium: _style(
        size: 16,
        height: 24,
        weight: FontWeight.w500,
        letterSpacing: 0.15,
        color: color,
      ),
      titleSmall: _style(
        size: 14,
        height: 20,
        weight: FontWeight.w500,
        letterSpacing: 0.1,
        color: color,
      ),

      // Body
      bodyLarge: _style(
        size: 16,
        height: 24,
        weight: FontWeight.w400,
        letterSpacing: 0.5,
        color: color,
      ),
      bodyMedium: _style(
        size: 14,
        height: 20,
        weight: FontWeight.w400,
        letterSpacing: 0.25,
        color: color,
      ),
      bodySmall: _style(
        size: 12,
        height: 16,
        weight: FontWeight.w400,
        letterSpacing: 0.4,
        color: color,
      ),

      // Label (a.k.a. captions / button text)
      labelLarge: _style(
        size: 14,
        height: 20,
        weight: FontWeight.w500,
        letterSpacing: 0.1,
        color: color,
      ),
      labelMedium: _style(
        size: 12,
        height: 16,
        weight: FontWeight.w500,
        letterSpacing: 0.5,
        color: color,
      ),
      labelSmall: _style(
        size: 11,
        height: 16,
        weight: FontWeight.w500,
        letterSpacing: 0.5,
        color: color,
      ),
    );
  }

  static TextStyle _base({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        package: null, // set if your font is in a package
        color: color,
      );

  static TextStyle _style({
    required double size,
    required double height,
    required FontWeight weight,
    required double letterSpacing,
    Color? color,
  }) {
    return _base(color: color).copyWith(
      fontSize: size,
      fontWeight: weight,
      height: height / size, // Flutter uses multiple of font size
      letterSpacing: letterSpacing,
    );
  }
}

/// Handy context getters that mimic Compose's `MaterialTheme.typography` access
extension TypographyX on BuildContext {
  TextTheme get typography => Theme.of(this).textTheme;

  TextStyle get displayLarge => typography.displayLarge!;

  TextStyle get displayMedium => typography.displayMedium!;

  TextStyle get displaySmall => typography.displaySmall!;

  TextStyle get headlineLarge => typography.headlineLarge!;

  TextStyle get headlineMedium => typography.headlineMedium!;

  TextStyle get headlineSmall => typography.headlineSmall!;

  TextStyle get titleLarge => typography.titleLarge!;

  TextStyle get titleMedium => typography.titleMedium!;

  TextStyle get titleSmall => typography.titleSmall!;

  TextStyle get bodyLarge => typography.bodyLarge!;

  TextStyle get bodyMedium => typography.bodyMedium!;

  TextStyle get bodySmall => typography.bodySmall!;

  TextStyle get labelLarge => typography.labelLarge!;

  TextStyle get labelMedium => typography.labelMedium!;

  TextStyle get labelSmall => typography.labelSmall!;
}

// ------------------------------
// THEME WIRING
// ------------------------------
// In your main theme file:
//
// import 'app_typography.dart';
//
// ThemeData buildTheme(BuildContext context) {
//   final base = ThemeData(
//     useMaterial3: true,
//     colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
//   );
//
//   return base.copyWith(
//     textTheme: AppTypography.textTheme(context),
//   );
// }
//
// MaterialApp(
//   theme: buildTheme(context),
//   home: const MyHomePage(),
// );
//
// ------------------------------
// USAGE EXAMPLES
// ------------------------------
// Text('Big headline', style: context.headlineLarge);
// Text('Body text', style: context.bodyMedium);
// ElevatedButton(
//   onPressed: () {},
//   child: Text('Continue', style: context.labelLarge),
// );
//
// ------------------------------
// OPTIONAL: Google Fonts
// ------------------------------
// If you want to use Google Fonts, add `google_fonts` to pubspec and replace
// `_base` with something like:
//
// import 'package:google_fonts/google_fonts.dart';
//
// static TextStyle _base({Color? color}) => GoogleFonts.inter(color: color);
