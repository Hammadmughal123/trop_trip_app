import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  // variables
  User? user = FirebaseAuth.instance.currentUser;
  LatLng? userLocation;
  RxSet<Marker> markers = <Marker>{}.obs;
  GoogleMapController? mapController;

  // intial camera postion
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(40.730610, -73.935242), // Coordinates for New York City
    zoom: 13,
  );

  // run function in intial state
  @override
  void onInit() {
    super.onInit();
    fetchAndDisplayMarkers();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (userLocation != null) {
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: userLocation!,
            zoom: 13,
          ),
        ),
      );
    }
    update();
  }

  // add marker for showing the saved location of user 
  void addMarker(LatLng position) {
    String markerIdVal = 'marker_${DateTime.now().millisecondsSinceEpoch}';
    markers.add(
      Marker(
        markerId: MarkerId(markerIdVal),
        position: position,
        infoWindow: const InfoWindow(
          title: 'Saved Location',
          snippet: 'This is your saved location.',
        ),
      ),
    );

    // Access userLocation here if needed
    if (userLocation != null) {
      _moveCameraToUserLocation();
      log('User Location: ${userLocation}');
    }

    update();
  }

  // function for fetching data from firebase
 void fetchAndDisplayMarkers() async {
  if (user == null) {
    print('.................User is not signed in.');
    return;
  }

  try {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('locations')
        .doc(user!.uid)
        .get();

    if (documentSnapshot.exists) {
      var locationData = documentSnapshot.data() as Map<String, dynamic>;
      double latitude = locationData['latitude'];
      double longitude = locationData['longitude'];
      userLocation = LatLng(latitude, longitude);
      initialCameraPosition = CameraPosition(
        target: userLocation!,
        zoom: 13,
      );

      addMarker(userLocation!);
      if (userLocation != null) {
        _moveCameraToUserLocation();
      }

      update();
      log('....................${userLocation}');
    } else {
      print('No location data found in Firestore for user: ${user!.uid}');
    }
  } catch (e) {
    print('An error occurred while fetching the location: $e');
  }
}

  // function for change camera postion 

  void _moveCameraToUserLocation() {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: userLocation!,
          zoom: 13,
        ),
      ),
    );
  }
}
