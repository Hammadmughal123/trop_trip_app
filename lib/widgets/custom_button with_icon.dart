import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/utils/constants.dart';
import 'package:troptrip/widgets/my_text.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonName;
  const CustomButtonWithIcon({
    super.key,
    required this.onTap,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        50.0,
      ),
      child: Card(
        elevation: 10.0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Container(
          height: 50.0,
          width: Get.width / 2,
          decoration: BoxDecoration(
            gradient: AppTheme.appGradient(),
            borderRadius: BorderRadius.circular(
              50.0,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(
                  text: buttonName,
                  color: AppTheme.whiteColor,
                  weight: FontWeight.bold,
                ),
                const SizedBox(width: 10.0,),
                Image.asset(
                  AppConstants.kArrowIcon,
                  height: 20.0,
                  width: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
