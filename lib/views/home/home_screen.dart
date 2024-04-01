import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/views/home/all_users_screen.dart';
import 'package:troptrip/views/search_screen/search_friend_screen.dart';
import 'package:troptrip/widgets/custom_button%20with_icon.dart';
import 'package:troptrip/widgets/dialogs/map_widgets.dart';
import '../../controllers/home_controller.dart';
import '../../models/user_model.dart';
import '../../widgets/search_wiget.dart';
import 'package:flutter/gestures.dart';



class HomeScreen extends GetView<HomeController> {
    final UserModel? userModel;
  final User? firebaseUser;
  HomeScreen({Key?key,
    this.userModel,
    this.firebaseUser,
  }):super(key: key);

  final _key = GlobalKey<ExpandableFabState>();
    
 User? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final HomeController homeCtrl = Get.put<HomeController>(HomeController());

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        title: const SearchWidget(),
        backgroundColor: AppTheme.whiteColor, // Assuming a transparent AppBar
        elevation: 5,
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        distance: 80.0,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(
            Icons.add,
            size: 30.0,
          ),
          fabSize: ExpandableFabSize.small,
          foregroundColor: AppTheme.primaryColor,
          backgroundColor: AppTheme.whiteColor,
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: FloatingActionButtonBuilder(
          size: 36,
          builder: (BuildContext context, void Function()? onPressed,
              Animation<double> progress) {
            return FloatingActionButton.small(
              onPressed: onPressed,
              child: const Icon(
                Icons.close,
                size: 30,
                color: AppTheme.whiteColor,
              ),
            );
          },
        ),
        children: [
          MapWidgets(
            text: 'Popular',
            icon: Icons.local_fire_department,
            onTap: () {
              //Get.to(() => CountriesScreen());
            },
          ),
          MapWidgets(
            text: 'Favourite',
            icon: Icons.favorite,
            onTap: () {},
          ),
          MapWidgets(
            text: 'Bars',
            icon: Icons.local_bar,
            onTap: () {},
          ),
          MapWidgets(
            text: 'Restaurents',
            icon: Icons.restaurant_menu,
            onTap: () {},
          ),
          MapWidgets(
            text: 'Beach',
            icon: Icons.beach_access,
            onTap: () {},
          ),
          // FloatingActionButton(
          //   onPressed: () {
          //     final state = _key.currentState;
          //     if (state != null) {
          //       debugPrint('isOpen:${state.isOpen}');
          //       state.toggle();
          //     }
          //   },
          //   child: const Icon(
          //     Icons.share,
          //     size: 30,
          //   ),
          // ),
        ],
      ),

      body: GetBuilder<HomeController>(builder: (ctrl) {
        return Stack(
          children: <Widget>[
            GoogleMap(
            //  mapType: MapType.,
              onMapCreated: ctrl.onMapCreated,
              initialCameraPosition: ctrl.initialCameraPosition,
              markers: ctrl.markers,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              // Set other map properties if needed
            ),
            Positioned(
              top: 15.0,
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButtonWithIcon(
                          onTap: () {
                            Get.to(() => const AllUsers());
                          },
                          buttonName: 'All Users',
                        ),
                      ),
                      Expanded(
                        child: CustomButtonWithIcon(
                          onTap: () async {
                            
                           
                            DocumentSnapshot userData = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .doc(user!.uid)
                                .get();
                            UserModel userModel = UserModel.fromMap(
                                userData.data() as Map<String, dynamic>);
                            Get.to(() => SearchFriend(
                              userModel: userModel,
                              firebaseUser: user!,
                            ));
                          },
                          buttonName: 'Find Friends',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 10, // Adjust the positioning to match your design
            //   right: 10,
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       // Your logic to handle pressing this button
            //     },
            //     child: Icon(Icons.search),
            //   ),
            // ),
            // Add more Positioned widgets for each floating action button and other overlay widgets
          ],
        );
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Your logic for floating action button
      //   },
      //   child: Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
