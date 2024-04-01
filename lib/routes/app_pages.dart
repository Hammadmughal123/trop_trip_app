import 'package:get/get.dart';
import 'package:troptrip/bindings/password_recovery_binding.dart';
import 'package:troptrip/bindings/signup_binding.dart';
import 'package:troptrip/views/auth/password_recovery_screen.dart';
import 'package:troptrip/views/bottomnav/bottom_navbar_screen.dart';

import '../bindings/login_binding.dart';
import '../bindings/splash_binding.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/signup_screen.dart';
import '../views/splash/splash_screen.dart';


part 'app_routes.dart'; // Contains a class AppRoutes with all route names

class AppPages {
  static const INITIAL = AppRoutes.SPLASH;

  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.HOME,
    //   page: () => HomeScreen(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => SignupScreen(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: AppRoutes.PASSWORDRECOVERY,
      page: () => PasswordRecoveryScreen(),
      binding: PasswordRecovryBinding(),
    ),

    GetPage(
      name: AppRoutes.BOTTOMNAV,
      page: () => const BottomNavbarScreen(),
      //binding: PasswordRecovryBinding(),
    ),
    // Add more routes here
  ];
}
