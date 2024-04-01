import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/routes/app_pages.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/utils/constants.dart';

import '../custom_button.dart';

void showEmailSentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the dialog compact
            children: <Widget>[
              const SizedBox(height: 15.0),
              Image.asset(
                AppConstants.kMessage,
                height: 80.0,
                width: 80.0,
              ),
              const SizedBox(height: 30.0),
              const Text(
                "Email Verification Sent!",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text(
                  "Check your email and click the link to verify your email address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              CustomButton(
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.PASSWORDRECOVERY);
                  },
                  buttonName: 'Next'),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      );
    },
  );
}
