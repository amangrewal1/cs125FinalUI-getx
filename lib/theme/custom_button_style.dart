import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Gradient button style
  static BoxDecoration get gradientPrimaryToBlueDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(30.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.indigoA1004c,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              10,
            ),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment(1.0, 1),
          end: Alignment(-0.24, 0),
          colors: [
            theme.colorScheme.primary,
            appTheme.blue20001,
          ],
        ),
      );
  static BoxDecoration get gradientSecondaryContainerToPinkDecoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(14.h),
        gradient: LinearGradient(
          begin: Alignment(1.0, 1),
          end: Alignment(-0.24, 0),
          colors: [
            theme.colorScheme.secondaryContainer,
            appTheme.pink100,
          ],
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
