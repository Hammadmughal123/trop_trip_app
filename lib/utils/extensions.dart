// extensions.dart
import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  // Add padding extension to any widget
  Widget withPadding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }
}

extension CapitalizeExtension on String {
  // Capitalize the first letter of a string
  String get capitalize {
    if (this.isEmpty) return this;
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}

extension MediaQueryValues on BuildContext {
  // Get MediaQueryData easily
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MySizedBox on num {
  SizedBox get h => SizedBox(
        height: toDouble(),
      );
  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}

// Add more extensions as needed
