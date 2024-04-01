import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:troptrip/controllers/all_users_controller.dart';
import 'package:troptrip/widgets/custom_appbar.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  GoogleMapController? mapController;
  Set<Marker>? markers;

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(40.730610, -73.935242), // Coordinates for Nigeria
    zoom: 13,
  );

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    Get.put<AllUserController>(AllUserController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(appBarTitle: 'Trips'),
      body: GetBuilder<AllUserController>(builder: (ctrl) {
        return GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: initialCameraPosition,
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
