// Define a class to hold all constants
// Define a class to hold all constants

import 'package:flutter/material.dart';
import 'package:troptrip/themes/text_styles.dart';

class AppConstants {
  // Images: Assuming you have an 'assets/images' directory
  static const String kImageLogo = 'assets/images/logo.png';
  static const String kMessage = 'assets/images/message.png';
  static const String kGoogleIcon = 'assets/images/google.png';
  static const String kFacebookIcon = 'assets/images/facebook.png';
  static const String kProfileImage = 'assets/images/profile.png';


  static const String kImageSplashBackground = 'assets/images/splash_bg.png';
  static const String kImageProfilePlaceholder =
      'assets/images/profile_placeholder.png';
  // ... add more image paths as required

  // Icons: Assuming you have an 'assets/icons' directory
  static const String kIconEmail = 'assets/icons/Email.png';
  static const String kIconLock = 'assets/icons/Lock.png';
  static const String kIconProfile = 'assets/icons/profile.png';
  static const String kLocationIcon = 'assets/icons/location.png';
  static const String kSearchIcon = 'assets/icons/search.png';
  static const String kArrowIcon = 'assets/icons/arrow.png';


  // ... add more icon paths as required

  // Strings
  static const String kAppName = 'TropTrip';
  static const String kWelcomeMessage = 'Welcome to TropTrip!';
  static const String kLoginButton = 'Login';
  // ... add more strings as required

  
}

// Usage example in Flutter widgets:
// Image.asset(AppConstants.kImageLogo)
// Icon(AssetImage(AppConstants.kIconHome))
