import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:troptrip/themes/app_theme.dart';

class ScreenLoader extends StatelessWidget {
  const ScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 15.0,
        shape: const CircleBorder(),
        child: Container(
          height: 45.0,
          width: 45.0,
          decoration: const BoxDecoration(
            color: AppTheme.whiteColor,
            shape: BoxShape.circle,
          ),
          child: Center(
              child: SizedBox(
            height: 28.0,
            width: 28.0,
            child: Center(
                child: LoadingAnimationWidget.twistingDots(
                    size: 35.0,
                    leftDotColor: AppTheme.primaryColor,
                    rightDotColor: AppTheme.accentColor)),
          )),
        ),
      ),
    );
  }
}
