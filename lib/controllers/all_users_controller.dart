import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:video_player/video_player.dart';

import '../views/home/fullsceen_video_view.dart'; // Adjust import path if needed

class AllUserController extends GetxController {
  GoogleMapController? mapController;
  RxSet<Marker> markers = <Marker>{}.obs;
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(40.730610, -73.935242),
    zoom: 13,
  );
  List<LatLng> userLocations = [];
  VideoPlayerController videoController =
      VideoPlayerController.asset('assets/videos/e3.mp4');
  LatLng? userLocation;

  @override
  void onInit() {
    listenForUserLocations();
    super.onInit();
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? locationSubscription;

  void listenForUserLocations() {
    locationSubscription = FirebaseFirestore.instance
        .collection('locations')
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      try {
        userLocations = snapshot.docs.map((doc) {
          double latitude = doc['latitude'];
          double longitude = doc['longitude'];
          String userId = doc['userId'];
          return LatLng(latitude, longitude);
        }).toList();

        // Remove the set difference check, and always call createMarkers
        createMarkers(userLocations);
        print(
            '...................................................${userLocations.length}');
        if (userLocations.isNotEmpty) {
          initialCameraPosition = CameraPosition(
            target: userLocations[0],
            zoom: 13,
          );
          if (mapController != null) {
            mapController!.animateCamera(
              CameraUpdate.newCameraPosition(initialCameraPosition),
            );
          }
        }
      } catch (e) {
        log('Error fetching user locations: $e');
      }
    });
  }

  Set<Marker> createMarkers(List<LatLng> markerPositions) {
    log('Creating markers for positions: $markerPositions');

    markers.clear(); // Clear existing markers

    for (int i = 0; i < markerPositions.length; i++) {
      markers.add(Marker(
        markerId: MarkerId('marker_$i'),
        position: markerPositions[i],
        onTap: () => handleMarkerTap(MarkerId('marker_$i'), videoController),
      ));

      log('Added marker: $markers');
    }

    log('Markers in set: $markers');

    update();

    return markers;
  }

  void handleMarkerTap(
      MarkerId markerId, VideoPlayerController videoController) async {
    await videoController.initialize();
    await videoController.play();
    Get.to(
      () => FullScreenVideoPlayer(videoController: videoController),
      fullscreenDialog: true,
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    if (userLocations.isNotEmpty) {
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: userLocations[0],
            zoom: 13,
          ),
        ),
      );
    }
    update();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    videoController.dispose();
    super.dispose();
  }
}
