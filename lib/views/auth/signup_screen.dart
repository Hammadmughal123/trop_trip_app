import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:troptrip/controllers/signup_controller.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/widgets/custom_button.dart';
import 'package:troptrip/widgets/my_text.dart';
import 'package:troptrip/widgets/screen_loader.dart';


class SignupScreen extends GetView<SignupController> {
  final signUpCtrl = Get.put<SignupController>(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<SignupController>(
          builder: (ctrl) {
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
                        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                        const MyText(
                          align: TextAlign.start,
                          text: 'Create Account',
                          color: AppTheme.whiteColor,
                          size: 30.0,
                          weight: FontWeight.bold,
                          // Assuming this is your predefined text style
                        ),
                        const MyText(
                          align: TextAlign.start,
                          text: 'To get started now!',
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
                                        onChanged: controller.onUsernameChanged,
                                        decoration: const InputDecoration(
                                          labelText: 'Username',
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: AppTheme.iconColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextField(
                                        onChanged: controller.onEmailChanged,
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
                                        onChanged: controller.onPhoneChanged,
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                          labelText: 'Phone no.',
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            color: AppTheme.iconColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextField(
                                        onChanged: controller.onPasswordChanged,
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
                                        onTap: controller.register,
                                        buttonName: 'Create Account',
                                      ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have account?"),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const MyText(
                                text: 'Login',
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                controller.isLoading.value ? const Center(child: ScreenLoader()) : const SizedBox()
              ],
            );
          }
        ),
      ),
    );
  }
}
