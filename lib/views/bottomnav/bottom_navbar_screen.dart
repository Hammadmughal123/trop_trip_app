import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/views/chat/chat_screen_tab.dart';
import 'package:troptrip/views/home/home_screen.dart';
import 'package:troptrip/views/profile/profile_screen.dart';
import 'package:troptrip/views/reels/reels_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class BottomNavbarScreen extends StatefulWidget {
   final UserModel? userModel;
  final User? firebaseUser;
  const BottomNavbarScreen({super.key,  this.userModel,  this.firebaseUser});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final auth = FirebaseAuth.instance;
  int _currentPage = 0;
  final _pageController = PageController();
  final picker = ImagePicker();
  XFile? pickedFile;
  bool get showCameraButton => _currentPage == 1;
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showCameraButton
          ? FloatingActionButton(
              onPressed: () async {
                pickedFile = await picker.pickVideo(source: ImageSource.camera);
                if (pickedFile != null) {
                  final userId = auth.currentUser!.uid;

                  // Upload the video to Firebase Storage
                  Reference storageRef = firebaseStorage.ref().child(
                      'user_videos/$userId/${DateTime.now().toString()}.mp4');
                  UploadTask uploadTask =
                      storageRef.putFile(File(pickedFile!.path));

                  setState(() {
                    uploading = true;
                  });

                  // Optional: Get download URL to store in the database or use later
                  String downloadURL =
                      await (await uploadTask).ref.getDownloadURL();

                  // Save information in Firestore
                  await firebaseFirestore
                      .collection('videos')
                      .doc(userId)
                      .collection('videos')
                      .add({
                    'userID': userId,
                    'downloadURL': downloadURL,
                    'timestamp': FieldValue.serverTimestamp(),
                  });

                  setState(() {
                    uploading = false;
                  });

                  // Show upload complete message
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Video Uploaded Successfully!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.camera,
                color: AppTheme.primaryColor,
                size: 45.0,
              ),
            )
          : null, // Set to null if not on "Reels" screen
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
           HomeScreen(
        userModel: widget.userModel,
        firebaseUser: widget.firebaseUser,    
           ),
              const ReelsScreen(),
              const ChatScreenTabs(),
              ProfileScreen(),
            ],
            onPageChanged: (index) {
              // Use a better state management solution
              // setState is used for simplicity
              setState(() => _currentPage = index);
            },
          ),
          if (uploading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        // selectedIndex: _currentPage,
        option: AnimatedBarOptions(
          //barStyle: BubbleBarStyle.horizotnal,
          // barStyle: BubbleBarStyle.vertical,
          //bubbleFillStyle: BubbleFillStyle.fill,

          iconStyle: IconStyle.Default,

          //bubbleFillStyle: BubbleFillStyle.outlined,
          opacity: 0.3,
        ),
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        currentIndex: _currentPage,
        items: <BottomBarItem>[
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            selectedColor: AppTheme.primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.play_circle_outline_outlined),
            title: const Text('Reels'),
            selectedColor: AppTheme.primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.forum_outlined),
            title: const Text('Chats'),
            selectedColor: AppTheme.primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person_2_outlined),
            title: const Text('Profile'),
            selectedColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}
