import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/widgets/dialogs/email_sent_dialog.dart';

import '../custom_button.dart';

void showPasswordRecovryDialog(BuildContext context) {
  TextEditingController emailController = TextEditingController();
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // To make the dialog compact
            children: <Widget>[
              const SizedBox(height: 15.0),
              const Text(
                "Password Recovry!",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Can't remember your password? No problem at all\nKindly provide email used for signup!",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppTheme.iconColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Center(
                  child: CustomButton(
                      onTap: () {
                        Get.back();
                        showEmailSentDialog(context);
                      },
                      buttonName: 'Next')),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      );
    },
  );
}
