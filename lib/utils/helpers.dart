// helpers.dart
import 'enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Validators {
  // Email and password validators
  static bool isValidEmail(String email) {
    return RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b').hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 8;
  }
}

class AuthExceptionHandler {
  static AuthResultStatus handleException(FirebaseAuthException e) {
    AuthResultStatus result;
    switch (e.code) {
      case 'invalid-email':
        result = AuthResultStatus.userNotFound;
        break;
      case 'wrong-password':
        result = AuthResultStatus.wrongPassword;
        break;
      case 'user-not-found':
        result = AuthResultStatus.userNotFound;
        break;
      case 'user-disabled':
        result = AuthResultStatus.userDisabled;
        break;
      case 'too-many-requests':
        result = AuthResultStatus.tooManyRequests;
        break;
      case 'email-already-in-use':
        result = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        result = AuthResultStatus.undefined;
    }
    return result;
  }

  static String generateErrorMessage(AuthResultStatus status) {
    String message;
    switch (status) {
      case AuthResultStatus.userNotFound:
        message = "Account not found for that email.";
        break;
      case AuthResultStatus.wrongPassword:
        message = "Wrong password. Please try again.";
        break;
      case AuthResultStatus.userDisabled:
        message = "This user has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        message = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        message = "An account already exists for that email.";
        break;
      default:
        message = "An undefined Error happened.";
    }
    return message;
  }

  
}

String? validateField(String? val) {
  if (val!.isEmpty) {
    return '*please fill this field';
  }
}
// Add more helper classes or functions as needed
