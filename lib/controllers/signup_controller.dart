import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:troptrip/themes/app_theme.dart';

import '../models/user_model.dart';
import '../widgets/dialogs/account_success_dialog.dart';

class SignupController extends GetxController {
  // Controllers for text fields
  var username = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  // Controllers for getting location
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  Position? currentPosition;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void onUsernameChanged(String username) {
    this.username.value = username.trim();
  }

  void onEmailChanged(String email) {
    this.email.value = email.trim();
  }

  void onPhoneChanged(String phone) {
    this.phoneNumber.value = phone.trim();
  }

  void onPasswordChanged(String password) {
    this.password.value = password.trim();
  }

  Future<void> register() async {
    if (!validateFields()) return;

    try {
      // for location
      try {
        currentPosition = await getCurrentLocation();
      } catch (locationError) {
        // Handle location error
        isLoading.value = false;
        Get.snackbar('Location Error', locationError.toString(),
            backgroundColor: Colors.red, colorText: AppTheme.whiteColor);
        return;
      }

      isLoading.value = true;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username.value,
        'email': email.value,
        'phone': phoneNumber.value,
        'password': password.value,
        'userId': userCredential.user!.uid,
        // Add other fields as necessary
      });

      await _firestore
          .collection('locations')
          .doc(userCredential.user!.uid)
          .set({
        'userId': userCredential.user!.uid,
        'latitude': currentPosition?.latitude ?? null,
        'longitude': currentPosition?.longitude ?? null,
        // Add other fields as necessary
      });

      isLoading.value = false;
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);

      showAccountSuccessDialog(Get.context!, userModel,
          userCredential.user); // You might want to pass context if needed
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.message ?? 'An unexpected error occurred',
        backgroundColor: Colors.red,
        colorText: AppTheme.whiteColor,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red,
        colorText: AppTheme.whiteColor,
      );
    }
  }

  bool validateFields() {
    if (username.value.isEmpty ||
        email.value.isEmpty ||
        phoneNumber.value.isEmpty ||
        password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        backgroundColor: Colors.red,
        colorText: AppTheme.whiteColor,
      );
      return false;
    }
    // Here you can add more validation for email, password etc.
    return true;
  }

  // permission from user for location
  Future<Position> getCurrentLocation() async {
    // Request permission
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return Future.error("Location permission denied");
    }

    // Get current location
    return await Geolocator.getCurrentPosition();
  }
}
