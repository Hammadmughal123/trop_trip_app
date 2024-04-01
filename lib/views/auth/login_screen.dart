import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:text_divider/text_divider.dart';
import 'package:troptrip/routes/app_pages.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/utils/constants.dart';
import 'package:troptrip/widgets/custom_button.dart';
import 'package:troptrip/widgets/dialogs/password_recovery_dialog.dart';
import 'package:troptrip/widgets/my_text.dart';
import '../../controllers/login_controller.dart';
import '../../widgets/screen_loader.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCtrl = Get.put<LoginController>(LoginController());
    return Scaffold(
      body: SafeArea(
        child: GetX<LoginController>(builder: (ctrl) {
          return Stack(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: Get.height / 2,
                  decoration: BoxDecoration(
                    gradient: AppTheme.appGradient(),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      const MyText(
                        align: TextAlign.start,
                        text: 'Welcome Back',
                        color: AppTheme.whiteColor,
                        size: 30.0,
                        weight: FontWeight.bold,
                        // Assuming this is your predefined text style
                      ),
                      const MyText(
                        align: TextAlign.start,
                        text: 'Glad to see you!',
                        color: AppTheme.whiteColor,
                        size: 20.0,
                        weight: FontWeight.normal,
                        // Assuming this is your predefined text style
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Card(
                            elevation: 20.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.whiteColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: controller.emailController,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: AppTheme.iconColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller: controller.passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: AppTheme.iconColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  
                                    CustomButton(
                                        onTap: () {
                                          controller
                                              .loginWithEmailAndPassword();
                                          
                                        },
                                        buttonName: 'Login'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              showPasswordRecovryDialog(context);
                            },
                            child: const MyText(
                              text: 'Forgot your password?',
                              align: TextAlign.center,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          TextDivider.horizontal(
                              text: const Text(
                            'or continue with',
                            style: TextStyle(color: AppTheme.iconColor),
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset(
                                  AppConstants.kGoogleIcon,
                                  height: 50.0,
                                  width: 50.0,
                                ), // Replace with your asset
                                onPressed: controller.loginWithGoogle,
                              ),
                              IconButton(
                                icon: Image.asset(
                                  AppConstants.kFacebookIcon,
                                  height: 50.0,
                                  width: 50.0,
                                ), // Replace with your asset
                                onPressed: controller.loginWithFacebook,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have account?"),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.SIGNUP);
                                },
                                child: const MyText(
                                  text: 'Sign Up',
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const Center(child: ScreenLoader())
                  : const SizedBox()
            ],
          );
        }),
      ),
    );
  }
}
