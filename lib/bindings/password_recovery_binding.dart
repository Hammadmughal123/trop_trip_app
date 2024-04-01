import 'package:get/get.dart';
import 'package:troptrip/controllers/password_recovery_controller.dart';
import 'package:troptrip/controllers/signup_controller.dart';

import '../controllers/login_controller.dart';

class PasswordRecovryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordRecoveryController>(() => PasswordRecoveryController());
  }
}
