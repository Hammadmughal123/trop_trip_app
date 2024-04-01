import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/controllers/profile_controller.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/utils/constants.dart';
import 'package:troptrip/utils/helpers.dart';
import 'package:troptrip/widgets/custom_appbar.dart';
import 'package:troptrip/widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final profileCtrl = Get.put<ProfileController>(ProfileController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: 'Edit Profile',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.whiteColor,
          ),
        ),
      ),
      body: GetBuilder<ProfileController>(builder: (ctrl) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: 120,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppTheme.primaryColor, width: 1.0),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      //fit: BoxFit.cover,
                      image: AssetImage(
                        AppConstants.kProfileImage,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: profileCtrl.nameCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: profileCtrl.userNameCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: profileCtrl.emailCtrl,
                  validator: validateField,
                  readOnly: true,
                  onTap: () {
                    Get.snackbar(
                      AppConstants.kAppName,
                      'Email cannot be edited',
                      backgroundColor: Colors.red,
                      colorText: AppTheme.whiteColor,
                      duration: const Duration(
                        seconds: 2,
                      ),
                    );
                  },
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: profileCtrl.phoneCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: profileCtrl.descCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: profileCtrl.websiteCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(labelText: 'Website'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomButton(
                  onTap: () {
                    ctrl.updateUserData().then((value) {
                     Get.back();
                    });
                    Get.snackbar(
                      AppConstants.kAppName,
                      'Updating Profile',
                      backgroundColor: Colors.blue,
                      colorText: AppTheme.whiteColor,
                      duration: const Duration(
                        seconds: 2,
                      ),
                    );
                  },
                  buttonName: 'Update',
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
