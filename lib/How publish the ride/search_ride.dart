import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Add this import to use geocoding for converting addresses to LatLng

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  RxInt values = 1.obs;
  Completer<GoogleMapController> controller = Completer();

  // Initial camera position
  static CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(29.386375, 76.961264),
    zoom: 14.4746,
  );

  List<Marker> markers = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(29.386375, 76.961264),
      infoWindow: InfoWindow(
        title: 'My Position Marker',
        snippet: 'My Position Marker',
      ),
    ),
  ];

  // To store the polyline
  Set<Polyline> polylines = {};

  // TextEditingControllers for the text fields
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  // This method will be called when user presses the search button
  Future<void> _drawRoute() async {
    try {
      // Convert addresses to coordinates
      List<Location> startPlacemark =
          await locationFromAddress(sourceController.text);
      List<Location> endPlacemark =
          await locationFromAddress(destinationController.text);

      // Extract the LatLng from the results
      LatLng startLatLng =
          LatLng(startPlacemark.first.latitude, startPlacemark.first.longitude);
      LatLng endLatLng =
          LatLng(endPlacemark.first.latitude, endPlacemark.first.longitude);

      // Add markers for source and destination
      setState(() {
        markers.add(Marker(
          markerId: const MarkerId('source'),
          position: startLatLng,
          infoWindow: InfoWindow(
            title: 'Source Location',
            snippet: sourceController.text,
          ),
        ));

        markers.add(Marker(
          markerId: const MarkerId('destination'),
          position: endLatLng,
          infoWindow: InfoWindow(
            title: 'Destination Location',
            snippet: destinationController.text,
          ),
        ));

        // Add a polyline between source and destination
        polylines.add(Polyline(
          polylineId: const PolylineId('route'),
          points: [startLatLng, endLatLng],
          color: Colors.blue,
          width: 5,
        ));
      });

      // Move the camera to the source location
      GoogleMapController mapController = await controller.future;
      mapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
              startLatLng.latitude < endLatLng.latitude
                  ? startLatLng.latitude
                  : endLatLng.latitude,
              startLatLng.longitude < endLatLng.longitude
                  ? startLatLng.longitude
                  : endLatLng.longitude),
          northeast: LatLng(
              startLatLng.latitude > endLatLng.latitude
                  ? startLatLng.latitude
                  : endLatLng.latitude,
              startLatLng.longitude > endLatLng.longitude
                  ? startLatLng.longitude
                  : endLatLng.longitude),
        ),
        50.0, // padding
      ));
    } catch (e) {
      // Show error if geocoding fails
      Get.snackbar('Error', 'Failed to get location for the provided address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Publish a Ride ",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 520,
                  height: 830,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: sourceController,
                            decoration: InputDecoration(
                              hintText: "Enter Source Location",
                              hintStyle: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: destinationController,
                            decoration: InputDecoration(
                              hintText: "Enter Destination Location",
                              hintStyle: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 484,
                          width: double.infinity,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: GoogleMap(
                            markers: Set<Marker>.of(markers),
                            polylines: polylines,
                            mapType: MapType.normal,
                            onMapCreated: (GoogleMapController contoller) {
                              controller.complete(contoller);
                            },
                            initialCameraPosition:
                                _GoogleMapScreenState.kGooglePlex,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _drawRoute,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text(
                            'Set Location ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Positioned(
                          top: 400,
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                border: Border.all(color: Colors.green)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Obx(() => Text(
                                      "Step$values/5",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                                InkWell(
                                    onTap: () {
                                      if (values < 5) {
                                        values++;
                                      }
                                    },
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 18,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 242,
                  top: 80,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.shade500)),
                    child: IconButton(
                      icon: const Icon(
                        Icons.shuffle,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          var temp = sourceController.text.toString();
                          sourceController.text = destinationController.text;
                          destinationController.text = temp.toString();
                        });

                        // Handle the button press here.
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: 'Book a Ride'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), label: 'Publish'),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), label: 'Your Rides'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: GoogleMapScreen(),
  ));
}

/*
Comments:
1. The `geocoding` package is used to convert the addresses entered in the text fields into latitude and longitude (`LatLng`).
2. Markers are added to indicate the source and destination locations on the map.
3. A polyline is drawn between the source and destination markers to represent the route.
4. The map camera adjusts to fit both the source and destination locations within the view.
5. The `GoogleMapController` is used to animate the camera position to the route.
6. The `Get.snackbar` function is used to display an error message if the location cannot be found.
7. The `TextEditingController` is used to manage the input of source and destination locations.
8. The `FloatingActionButton` is used to move the camera to a different location (e.g., Tokyo) for testing purposes.
9. Dependencies `google_maps_flutter` and `geocoding` must be added to the `pubspec.yaml` file to use these features.
*/
