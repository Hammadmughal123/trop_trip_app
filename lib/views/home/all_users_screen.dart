import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:troptrip/controllers/all_users_controller.dart';
import 'package:troptrip/widgets/custom_appbar.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {



  @override
  Widget build(BuildContext context) {
    Get.put<AllUserController>(AllUserController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(appBarTitle: 'All Users'),
      body: GetBuilder<AllUserController>(builder: (ctrl) {
        return GoogleMap(
            onMapCreated:ctrl. onMapCreated,
            initialCameraPosition: ctrl.initialCameraPosition,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            markers: ctrl.markers,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            // Set other map properties if needed
          );
      }),
    );
  }
}
