// ProfileController.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:troptrip/views/profile/edit_profile_screen.dart';

import '../themes/app_theme.dart';

class ProfileController extends GetxController {
  //var username = 'david.kumar'.obs;
  var followerCount = 0.obs;
  var followingCount = 0.obs;
  var postCount = 0.obs;
  var albumCount = 0.obs;
  var isLoading = true.obs;
  String userId = '';
  RxInt tabIndex = 0.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String userName = '';
  String email = '';
  final nameCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final websiteCtrl = TextEditingController();
  late final Stream<QuerySnapshot>? userDataStream;

  @override
  void onInit() {
    getUserData().then(
      (value) {
        fetchUserData(userId).then((value) {
          userNameCtrl.text = userName;
          emailCtrl.text = email;

          update();
        });
      },
    );

    userDataStream = FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userId) // Filter by user ID
        .snapshots();

    super.onInit();
  }

  // Dummy list for posts thumbnails
  var postsThumbnails = [
    'assets/images/dummy1.png',
    'assets/images/dummy2.png',
    // Add more asset paths for the thumbnails
  ].obs;

  var tripThumbnails = [
    'assets/images/dummy1.png',
    'assets/images/dummy2.png',
    // Add more asset paths for the thumbnails
  ].obs;

  var tripAlbums = [
    'assets/images/dummy1.png',
    'assets/images/dummy2.png',
    'assets/images/dummy1.png',
    'assets/images/dummy2.png',
    'assets/images/dummy1.png',
    'assets/images/dummy2.png',
    // Add more asset paths for the thumbnails
  ].obs;

  var tripAlbumsNames = [
    'Album 1',
    'Album 2',
    'Album 3',
    'Album 4',
    'Album 5',
    'Album 6',
  ].obs;

  var tripCountries = [
    'assets/images/mapvert.png',
    'assets/images/maphorz.png',
    'assets/images/mapvert.png',
    'assets/images/maphorz.png',
    'assets/images/mapvert.png',
    'assets/images/maphorz.png',
    'assets/images/mapvert.png',
    'assets/images/maphorz.png',
    // Add more asset paths for the thumbnails
  ].obs;

  var countriesName = [
    'United States',
    'Canada',
    'Austrailia',
    'UAE',
    'Qatar',
    'South Africa',
    'India',
    'Germany',
    // Add more asset paths for the thumbnails
  ].obs;

  var citiesName = [
    'New York',
    'Toronto',
    'Sydney',
    'Dubai',
    'Sharjah',
    'Islamabad',
    'Riyadh',
    'Jakarta',
    // Add more asset paths for the thumbnails
  ].obs;

  void onEditProfile() {
    Get.to(() => EditProfileScreen());
  }

  void onDeleteAccount() {
    // TODO: Implement functionality
  }

  void shareAccount() async {
    await Share.share(
        'Hey, checkout my Profile on TropTrip App: https://play.google.com/store/apps/details?id=com.example.troptrip');
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('user')) {
      userId = preferences.getString('user')!;
    }
  }

  Future<void> getUserData() async {
    await Future.delayed(const Duration(seconds: 3));
    if (firebaseAuth.currentUser != null) {
      userId = firebaseAuth.currentUser!.uid;
      update();
    }
  }

  Future<void> fetchUserData(String userId) async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        final Map<String, dynamic> userData =
            snapshot.data() as Map<String, dynamic>;
        userName = userData['username'];
        email = userData['email'];
        isLoading.value = false;
        update();
        //return {'username': userName, 'email': email};
      } else {
        // Handle the case where the user document doesn't exist
        isLoading.value = false;
        return null;
      }
    } catch (error) {
      // Handle any errors that may occur during the fetch
      isLoading.value = false;
      print('Error fetching user data: $error');
      return null;
    }
  }

  Future<void> updateUserData() async {
    Map<String, dynamic> data = {
      'name': nameCtrl.text,
      'username': userNameCtrl.text,
      'phone': phoneCtrl.text,
      'desc': descCtrl.text,
      'website': websiteCtrl.text,
    };
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update(data)
          .then((value) {
        userName = userNameCtrl.text;
        email = emailCtrl.text;
        update();

        Get.snackbar(
          AppConstants.kAppName,
          'Profile Updated',
          backgroundColor: Colors.blue,
          colorText: AppTheme.whiteColor,
          duration: const Duration(
            seconds: 2,
          ),
        );
        
      });
    } catch (error) {
      // Handle any errors that may occur during the fetch

      print('Error fetching user data: $error');
      return null;
    }
  }

  void changeTab(int index) {
    tabIndex.value = index;
  }
}
