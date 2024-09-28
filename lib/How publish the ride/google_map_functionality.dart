import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> controller = Completer();

  static CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(29.386375, 76.961264),
    zoom: 14.4746,
  );

  List<Marker> marker = [];
  List<Marker> markers = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(29.386375, 76.961264),
      infoWindow: InfoWindow(
        title: 'My Position Marker',
        snippet: 'My Position Marker',
      ),
    ),
    const Marker(
      markerId: MarkerId('2'),
      position: LatLng(29.386375, 76.961274),
      infoWindow: InfoWindow(
        title: 'My Position Marker',
        snippet: 'My Position Marker',
      ),
    ),
    const Marker(
      markerId: MarkerId('3'),
      position: LatLng(29.386375, 76.961276),
      infoWindow: InfoWindow(
        title: 'My Position Marker',
        snippet: 'My Position Marker',
      ),
    ),
    const Marker(
      markerId: MarkerId('4'),
      position: LatLng(29.386375, 76.961285),
      infoWindow: InfoWindow(
        title: 'My Position Marker',
        snippet: 'My Position Marker',
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    marker.addAll(markers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              controller.future.then((value) => value.animateCamera(
                  CameraUpdate.newCameraPosition(kGooglePlex)));
            },
            child: const Text('Panipat'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400, // Set the height of the container
              width: double.infinity, // Set the width of the container
              margin: const EdgeInsets.all(10.0), // Add some margin
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent), // Add a border if needed
              ),
              child: GoogleMap(
                markers: Set<Marker>.of(marker),
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController contoller) {
                  controller.complete(contoller);
                },
                initialCameraPosition: HomeScreenState.kGooglePlex,
              ),
            ),
            // Add other widgets below the map if needed
            // Example:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Additional Content Below the Map",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.future.then((value) =>
              value.animateCamera(CameraUpdate.newCameraPosition(
                const CameraPosition(
                    target: LatLng(35.6762, 139.6503), zoom: 14.4746),
              )));
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}
