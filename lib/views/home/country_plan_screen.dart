import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/controllers/profile_controller.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/widgets/custom_appbar.dart';
import 'package:troptrip/widgets/my_text.dart';

class CountryPlanScreen extends StatefulWidget {
  const CountryPlanScreen({super.key});

  @override
  State<CountryPlanScreen> createState() => _CountryPlanScreenState();
}

class _CountryPlanScreenState extends State<CountryPlanScreen> {
  final controller = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarTitle: 'Country Visit'),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const MyText(
                text: 'Day 1',
                color: AppTheme.blackColor,
                size: 15.0,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 20.0,),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                itemCount: controller.tripAlbums.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    controller.tripAlbums[index],
                    fit: BoxFit.fill,
                  ); // Replace with the actual image paths
                },
              ),
        
              const SizedBox(height: 20.0,),
              const MyText(
                text: 'Day 2',
                color: AppTheme.blackColor,
                size: 15.0,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20.0,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                itemCount: controller.tripAlbums.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    controller.tripAlbums[index],
                    fit: BoxFit.fill,
                  ); // Replace with the actual image paths
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
