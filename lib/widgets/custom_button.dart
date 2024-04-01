import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/widgets/my_text.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonName;
  const CustomButton({
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
        elevation: 0.0,
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
            child: MyText(
              text: buttonName,
              color: AppTheme.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
