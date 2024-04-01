import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/themes/app_theme.dart';

import '../custom_button.dart';

void showPasswordSuccessDialog(BuildContext context) {
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
            mainAxisSize: MainAxisSize.min,
            // To make the dialog compact
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
                "You've Changed Your Password!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text(
                  "You've successfully changed your password, let's begin to explore",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              CustomButton(onTap: () {}, buttonName: 'Explore'),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      );
    },
  );
}
