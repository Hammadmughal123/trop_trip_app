import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/models/user_model.dart';
import 'package:troptrip/routes/app_pages.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/views/bottomnav/bottom_navbar_screen.dart';

import '../custom_button.dart';

void showAccountSuccessDialog(BuildContext context,UserModel userModel,User? firebase) {
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
              Container(
                height: 90.0,
                width: 90.0,
                decoration: BoxDecoration(
                  gradient: AppTheme.appGradient(),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 50.0, color: Colors.white),
              ),
              const SizedBox(height: 30.0),
              const Text(
                "Your Account has been created!",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text(
                  "You've successfully created your account, let's begin to explore",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              CustomButton(
                  onTap: () {
                    Get.off(()=>BottomNavbarScreen(
                      userModel: userModel,
                      firebaseUser: firebase,
                    ));
                  },
                  buttonName: 'Explore'),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      );
    },
  );
}
