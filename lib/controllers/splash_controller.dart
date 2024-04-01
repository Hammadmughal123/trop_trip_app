import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Check if user is logged in
    if (FirebaseAuth.instance.currentUser != null) {
      // If the user is logged in, navigate to the BottomNavBar screen
      Get.offNamed(AppRoutes.BOTTOMNAV); // Update with your actual route
    } else {
      // If the user is not logged in, navigate to the Login screen
      Get.offNamed(AppRoutes.LOGIN);
    }
  }
}
