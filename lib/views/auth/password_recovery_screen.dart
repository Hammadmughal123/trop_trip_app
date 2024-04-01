import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:troptrip/controllers/password_recovery_controller.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/widgets/custom_button.dart';
import 'package:troptrip/widgets/dialogs/password_success_dialog.dart';
import 'package:troptrip/widgets/my_text.dart';

class PasswordRecoveryScreen extends GetView<PasswordRecoveryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                      text: 'Create a new password',
                      maxlines: 2,
                      color: AppTheme.whiteColor,
                      size: 25.0,
                      weight: FontWeight.bold,
                      // Assuming this is your predefined text style
                    ),
                    const MyText(
                      align: TextAlign.start,
                      text:
                          'Remember to create a strong password, that can not be forgotton!',
                      maxlines: 2,
                      color: AppTheme.whiteColor,
                      size: 14.0,
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
                                    onChanged: controller.onEmailChanged,
                                    decoration: const InputDecoration(
                                      labelText: 'New Password',
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppTheme.iconColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    onChanged: controller.onPasswordChanged,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Confirm Password',
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppTheme.iconColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  CustomButton(
                                      onTap: () {
                                        showPasswordSuccessDialog(context);
                                      },
                                      buttonName: 'Next'),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
