import 'package:flutter/material.dart';

import 'text_styles.dart';

class AppTheme {
  // Define the color palette
  static const Color primaryColor = Color(0xFF0083B0); // Example color
  static const Color accentColor = Color(0xFFD44638); // Example color
  static const Color whiteColor = Colors.white; // Example color
  static const Color blackColor = Colors.black; // Example color
  
  static const Color backgroundColor = Color(0xFFF1F5F9); // Example color
  static const Color cardColor = Color(0xFFFFFFFF); // Example color
  static const Color iconColor = Color(0xFF707070); // Example color
  static const Color textColor = Color(0xFF333333); // Example color

  // Define the light theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,
    //useMaterial3: true,
    iconTheme: const IconThemeData(color: iconColor),
    textTheme: const TextTheme(
      // Use TextStyles from text_styles.dart
      bodyText1: TextStyles.bodyText,
      headline1: TextStyles.heading,
      // ... other text styles
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
    // ... other theme data
  );

  static LinearGradient appGradient() {
    return const LinearGradient(
      colors: [
        Color(0xff3DD9FF),
        Color(0xff00ABD4),
        Color(
          0xff0082FA,
        ),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
