import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/utils/constants.dart';
import '../../controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  final SplashController splashController = Get.put(SplashController());

    SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Replace with your background color
      body: Stack(
        children: <Widget>[
          // Your background design
          Center(
            child: Image.asset(AppConstants.kImageLogo), // Replace with your image path
          ),
          // Your animated text or any other widget
        ],
      ),
    );
  }
}
