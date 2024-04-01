import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/utils/constants.dart';
import 'package:troptrip/views/home/countries.dart';
import 'package:troptrip/views/profile/album_screen.dart';
import 'package:troptrip/views/profile/trips_screen.dart';
import 'package:troptrip/widgets/custom_appbar.dart';
import 'package:troptrip/widgets/custom_button.dart';
import 'package:troptrip/widgets/my_text.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
   

   ProfileScreen({super.key});

 
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
    
  final ProfileController controller = Get.put(ProfileController());
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this); // Now we have a TickerProvider
  }

  @override
  void dispose() {
    _tabController?.dispose(); // Don't forget to dispose of the controller
    super.dispose();
  }

  void showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(
              30.0,
            )),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // List of settings items
              ListTile(
                title: const Text('General Settings'),
                onTap: () {
                  // Handle general settings navigation
                },
              ),
              ListTile(
                title: const Text('Change Password'),
                onTap: () {
                  // Handle change password navigation
                },
              ),
              ListTile(
                title: const Text('Blocked Users'),
                onTap: () {
                  // Handle blocked users navigation
                },
              ),
              ListTile(
                title: const Text('Privacy Policy'),
                onTap: () {
                  // Handle privacy policy navigation
                },
              ),
              ListTile(
                title: const Text('Profile Settings'),
                onTap: () {
                  // Handle profile settings navigation
                },
              ),
              const SizedBox(height: 20), // Add spacing before logout button
              CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  buttonName: 'Logout')
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (ctrl) {
      return Scaffold(
        appBar: CustomAppBar(
            appBarTitle: ctrl.userName,
            action: IconButton(
              onPressed: () {
                showSettingsBottomSheet(context);
              },
              icon: const Icon(
                Icons.more_horiz,
                color: AppTheme.whiteColor,
              ),
            )),
        body: ctrl.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                  AppConstants.kProfileImage,
                                ), // Replace with user profile image
                                radius: 40,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 4,
                                    left: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildStatisticItem('Follower',
                                          controller.followerCount.toString()),
                                      _buildStatisticItem('Following',
                                          controller.followingCount.toString()),
                                      _buildStatisticItem('Posts',
                                          controller.postCount.toString()),
                                      _buildStatisticItem('Albums',
                                          controller.albumCount.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 2.0,
                                ),
                                child: MyText(
                                  text: ctrl.userName,
                                  size: 20,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: Get.width / 3,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  gradient: AppTheme.appGradient(),
                                  borderRadius: BorderRadius.circular(
                                    50.0,
                                  ),
                                ),
                                child: Center(
                                  child: MyText(
                                    text: ctrl.email,
                                    size: 8.0,
                                    color: AppTheme.whiteColor,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: MyText(
                                  text:
                                      'Life is short and the world is wide. I better get started',
                                  maxlines: 3,
                                  size: 10.0,
                                  align: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        width: Get.width,
                        child: Row(
                          children: [
                            Expanded(
                                child: _buildButton(
                                    'Edit profile', controller.onEditProfile)),
                            Expanded(
                                child: _buildButton(
                                    'Share Profile', controller.shareAccount)),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true, // Implement with TickerProvider
                        tabs: const [
                          MyText(
                            text: 'Posts',
                            color: AppTheme.blackColor,
                          ),
                          MyText(
                            text: 'Trips',
                            color: AppTheme.blackColor,
                          ),
                          MyText(
                            text: 'Albums',
                            color: AppTheme.blackColor,
                          ),
                        ],
                        onTap: controller.changeTab,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: Get.height / 2,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                bottom: 8.0,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.7,
                                ),
                                itemCount: controller.postsThumbnails.length,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    controller.postsThumbnails[index],
                                    fit: BoxFit.fill,
                                  ); // Replace with the actual image paths
                                },
                              ),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                bottom: 8.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      // gridDelegate:
                                      //     const SliverGridDelegateWithFixedCrossAxisCount(
                                      //   crossAxisCount: 3,
                                      //   crossAxisSpacing: 8,
                                      //   mainAxisSpacing: 8,
                                      //   childAspectRatio: 0.7,
                                      // ),
                                      itemCount:
                                          controller.tripCountries.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap:(){
                                            Get.to(() => CountriesScreen());
                                          },
                                          
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 100.0,
                                                  width: 100.0,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                            controller
                                                                    .tripCountries[
                                                                index],
                                                          ),
                                                          fit: BoxFit.fill)),
                                                  // child: Image.asset(
                                                  //   controller.tripAlbums[index],
                                                  //   fit: BoxFit.fill,
                                                  // ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                MyText(
                                                  text: controller
                                                      .countriesName[index],
                                                )
                                              ],
                                            ),
                                          ),
                                        ); // Replace with the actual image paths
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const MyText(
                                    text: 'Favourite Places',
                                    weight: FontWeight.bold,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      // gridDelegate:
                                      //     const SliverGridDelegateWithFixedCrossAxisCount(
                                      //   crossAxisCount: 3,
                                      //   crossAxisSpacing: 8,
                                      //   mainAxisSpacing: 8,
                                      //   childAspectRatio: 0.7,
                                      // ),
                                      itemCount:
                                          controller.tripCountries.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(() => const TripsScreen());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 100.0,
                                                  width: 100.0,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                            controller
                                                                    .tripCountries[
                                                                index],
                                                          ),
                                                          fit: BoxFit.fill)),
                                                  // child: Image.asset(
                                                  //   controller.tripAlbums[index],
                                                  //   fit: BoxFit.fill,
                                                  // ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                MyText(
                                                  text: controller
                                                      .citiesName[index],
                                                )
                                              ],
                                            ),
                                          ),
                                        ); // Replace with the actual image paths
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                bottom: 8.0,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.7,
                                ),
                                itemCount: controller.tripAlbums.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => AlbumScreen(
                                          albumName:
                                              controller.tripAlbumsNames[index],
                                          albumList: controller.tripAlbums,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(controller
                                                  .tripAlbums[index]))),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: MyText(
                                            text: controller
                                                .tripAlbumsNames[index],
                                            color: AppTheme.whiteColor,
                                            weight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ); // Replace with the actual image paths
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }

  Widget _buildStatisticItem(String label, String count) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
            text: count,
            size: 18.0,
            weight: FontWeight.bold,
          ),
          MyText(
            text: label,
            size: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return CustomProfileButton(
      onTap: onPressed,
      buttonName: text,
    );
  }
}

class CustomProfileButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonName;
  const CustomProfileButton({
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
            child: MyText(
              text: buttonName,
              color: AppTheme.whiteColor,
              size: 10.0,
              maxlines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
