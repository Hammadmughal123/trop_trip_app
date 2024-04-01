import 'package:get/get.dart';

class PasswordRecoveryController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  void onEmailChanged(String email) {
    this.email.value = email;
  }

  void onPasswordChanged(String password) {
    this.password.value = password;
  }

  Future<void> login() async {
    // Implement login logic using FirebaseAuth or another service
    // ...
  }

  void loginWithGoogle() {
    // Implement Google login logic
    // ...
  }

  void loginWithFacebook() {
    // Implement Facebook login logic
    // ...
  }

  void goToSignUp() {
    Get.toNamed(
        '/signup'); // Assuming '/signup' is the named route for the sign-up screen
  }

  void goToForgotPassword() {
    Get.toNamed(
        '/forgot-password'); // Assuming '/forgot-password' is the named route
  }
}
