// ignore_for_file: deprecated_member_use

import 'package:cabmate_task/screens/ride/publish_ride_3.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PublishRideScreen2 extends StatefulWidget {
  const PublishRideScreen2(
      {super.key, required this.source, required this.destination});

  final String source;
  final String destination;

  @override
  State<PublishRideScreen2> createState() => _PublishRideScreen2State();
}

class _PublishRideScreen2State extends State<PublishRideScreen2> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(0, 0);
  bool _isLoading = true;
  int selectedIdx = 1;
  List<String> stops = [];

  // Markers
  final Set<Marker> _markers = {};
  LatLng? _srcMarker, _stop1Marker, _stop2Marker, _destMarker;

  // Controllers
  late TextEditingController _srcController;
  late TextEditingController _stop1Controller;
  late TextEditingController _stop2Controller;
  late TextEditingController _destController;

  @override
  void initState() {
    super.initState();

    _srcController = TextEditingController(text: widget.source);
    _stop1Controller = TextEditingController();
    _stop2Controller = TextEditingController();
    _destController = TextEditingController(text: widget.destination);

    WidgetsFlutterBinding.ensureInitialized();
    _getCurrentLocation();
  }

  Future<LatLng?> _getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Convert source and destination addresses to LatLng
    LatLng? srcPosition = await _getLatLngFromAddress(widget.source);
    LatLng? destPosition = await _getLatLngFromAddress(widget.destination);

    // If we have valid positions for both source and destination, set the markers
    if (srcPosition != null && destPosition != null) {
      setState(() {
        _srcMarker = srcPosition;
        _destMarker = destPosition;

        _markers.add(Marker(
          markerId: const MarkerId('source'),
          position: _srcMarker!,
          infoWindow: InfoWindow(title: 'Source', snippet: widget.source),
        ));

        _markers.add(Marker(
          markerId: const MarkerId('destination'),
          position: _destMarker!,
          infoWindow:
              InfoWindow(title: 'Destination', snippet: widget.destination),
        ));

        _currentPosition = srcPosition; // Center the map on the source
        _isLoading = false;
        _moveCamera(); // Move the camera to the source
      });
    } else {
      // Fallback to current location if source/destination cannot be geocoded
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
        _moveCamera();
      });
    }
  }

  Future<String> getAddressFromLatLng(LatLng position) async {
    try {
      // Check for invalid coordinates (LatLng 0, 0 may return no results)
      if (position.latitude == 0 && position.longitude == 0) {
        return 'Invalid coordinates';
      }

      // Call the reverse geocoding method to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // Construct the address from the placemark information
        return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      } else {
        return 'No address found for the given location';
      }
    } catch (e) {
      return 'Unable to get address - Need Authorization';
    }
  }

  void _moveCamera() {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _srcMarker ??
                _currentPosition, // Center on the source if available
            zoom: 14.0,
          ),
        ),
      );
    }
  }

  void _addMarker(LatLng tappedPoint, int markerType) async {
    String address = await getAddressFromLatLng(tappedPoint);

    setState(() {
      switch (markerType) {
        case 0: // Source
          _srcMarker = tappedPoint;
          _markers.add(Marker(
            markerId: const MarkerId('source'),
            position: _srcMarker!,
            infoWindow: InfoWindow(title: 'Source', snippet: address),
          ));
          _srcController.text = address;
          stops.add(address);
          break;
        case 1: // Stop 1
          _stop1Marker = tappedPoint;
          _markers.add(Marker(
            markerId: const MarkerId('stop1'),
            position: _stop1Marker!,
            infoWindow: InfoWindow(title: 'Stop 1', snippet: address),
          ));
          _stop1Controller.text = address;
          stops.add(address);
          break;
        case 2: // Stop 2
          _stop2Marker = tappedPoint;
          _markers.add(Marker(
            markerId: const MarkerId('stop2'),
            position: _stop2Marker!,
            infoWindow: InfoWindow(title: 'Stop 2', snippet: address),
          ));
          _stop2Controller.text = address;
          stops.add(address);
          break;
        case 3: // Destination
          _destMarker = tappedPoint;
          _markers.add(Marker(
            markerId: const MarkerId('destination'),
            position: _destMarker!,
            infoWindow: InfoWindow(title: 'Destination', snippet: address),
          ));
          _destController.text = address;
          stops.add(address);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Publish Ride',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition,
                      zoom: 14.0,
                    ),
                    onMapCreated: (controller) {
                      _mapController = controller;
                      _moveCamera();
                    },
                    myLocationEnabled: true,
                    markers: _markers,
                    onTap: (LatLng tappedPoint) {
                      // Allow adding markers based on tap location
                      if (_srcMarker == null) {
                        _addMarker(tappedPoint, 0);
                      } else if (_stop1Marker == null) {
                        _addMarker(tappedPoint, 1);
                      } else if (_stop2Marker == null) {
                        _addMarker(tappedPoint, 2);
                      } else if (_destMarker == null) {
                        _addMarker(tappedPoint, 3);
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Stop Over Points',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              _buildDottedStoppage(
                                  Colors.green, true, _srcController),
                              _buildDottedStoppage(
                                  Colors.black, false, _stop1Controller),
                              _buildDottedStoppage(
                                  Colors.black, false, _stop2Controller),
                              Row(
                                children: [
                                  Container(
                                    height: 20, // You can adjust the size
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                      ),
                                      child: TextFormField(
                                        controller: _destController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Add Dest'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back)),
                      ),
                      const Text(
                        'Steps 2/5',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      PublishRideScreen3(stops: stops)));
                            },
                            icon: const Icon(Icons.arrow_forward)),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

Widget _buildDottedStoppage(
    Color color, bool isTerminal, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      // Container above the dotted line
      Row(
        children: [
          Container(
            height: 20, // You can adjust the size
            width: 20,
            decoration: BoxDecoration(
              color: color, // Color of the container
              shape: isTerminal
                  ? BoxShape.circle
                  : BoxShape.rectangle, // Shape of the container (circle)
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: isTerminal ? 'Add Source' : 'Any Stop'),
              ),
            ),
          ),
        ],
      ),

      // Dotted line below the container
      Row(
        children: [
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 2.0), // space between dots
                child: Container(
                  height: 4, // size of each dot
                  width: 4,
                  decoration: const BoxDecoration(
                    color: Colors.grey, // dot color
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ],
  );
}
