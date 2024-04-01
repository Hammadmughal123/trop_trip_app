

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:troptrip/widgets/dialogs/login_success_dialog.dart';

import '../models/user_model.dart';
import '../themes/app_theme.dart';

class LoginController extends GetxController {
  // Controllers for text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  // Controllers for getting location
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  Position? currentPosition;


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  void loginWithEmailAndPassword() async {
    if (!validateFields()) return;
    try {
      isLoading.value = true;

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

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      isLoading.value = false;
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();

      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);

      showLoginSuccessDialog(Get.context!,userModel,userCredential.user!);
      // Proceed to next screen or show success dialog
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      // Handle different Firebase Auth exceptions
      _handleAuthError(e);
    }
  }

  void loginWithGoogle() async {
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

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled the sign in process
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _storeUserData(userCredential.user);
      // Proceed to next screen or show success dialog
    } catch (e) {
      // Handle general errors
      _handleGeneralError(e);
    }
  }

  void loginWithFacebook() async {
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

      final LoginResult result = await _facebookAuth.login();
      if (result.status != LoginStatus.success)
        return; // User cancelled the sign in process
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _storeUserData(userCredential.user);
      // Proceed to next screen or show success dialog
    } catch (e) {
      // Handle general errors
      _handleGeneralError(e);
    }
  }

  Future<void> _storeUserData(User? user) async {
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'username': user.displayName,
        'email': user.email,
        'phone': user.phoneNumber,
        'password': user.uid,
        'userId': user.uid,
        // Add other user details you want to store
      });

      await _firestore.collection('locaions').doc(user.uid).set({
        'userId': user.uid,
        'latitude': currentPosition?.latitude ?? null,
        'longitude': currentPosition?.longitude ?? null,
        // Add other fields as necessary
      });

    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'wrong-password':
        message = 'Wrong password provided for that user.';
        break;
      // Handle other FirebaseAuthException cases
      default:
        message = 'An unknown error occurred.';
    }
    Get.snackbar(
      'Authentication Error',
      message,
      backgroundColor: Colors.red,
      colorText: AppTheme.whiteColor,
    );
  }

  void _handleGeneralError(e) {
    Get.snackbar(
      'Error',
      'An error occurred: $e',
      backgroundColor: Colors.red,
      colorText: AppTheme.whiteColor,
    );
  }

  bool validateFields() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
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
