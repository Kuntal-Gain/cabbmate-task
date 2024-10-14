import 'package:cabmate_task/screens/ride/publish_ride_2.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PublishRideScreen1 extends StatefulWidget {
  const PublishRideScreen1({super.key});

  @override
  State<PublishRideScreen1> createState() => _PublishRideScreen1State();
}

class _PublishRideScreen1State extends State<PublishRideScreen1> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(0, 0);
  bool _isLoading = true;
  int selectedIdx = 1;

  // Markers
  final Set<Marker> _markers = {};
  LatLng? _srcMarker, _destMarker;

  // Controllers
  final _srcController = TextEditingController();
  final _destController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _getCurrentLocation();
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

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _isLoading = false;
      _moveCamera();
    });
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
            target: _currentPosition,
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
          break;

        case 1: // Destination
          _destMarker = tappedPoint;
          _markers.add(Marker(
            markerId: const MarkerId('destination'),
            position: _destMarker!,
            infoWindow: InfoWindow(title: 'Destination', snippet: address),
          ));
          _destController.text = address;
          break;
      }
    });
  }

  Future<void> _onSubmit(String input, bool isSource) async {
    try {
      // Get LatLng from address input
      List<Location> locations = await locationFromAddress(input);

      if (locations.isNotEmpty) {
        LatLng tappedPoint =
            LatLng(locations[0].latitude, locations[0].longitude);

        // Add marker based on whether it's source or destination
        if (isSource) {
          _addMarker(tappedPoint, 0);
        } else {
          _addMarker(tappedPoint, 1);
        }

        // Move camera to this location
        _mapController?.animateCamera(CameraUpdate.newLatLng(tappedPoint));
      } else {
        throw Exception('No locations found for the input address.');
      }
    } catch (e) {
      print('Failed to get location from address: $e');

      // Handle timeout or other errors by showing an alert or default fallback
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to get location from address: $e'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const Center(child: Text('Search')),
      _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDottedStoppage(Colors.green, true, _srcController,
                          (value) => _onSubmit(value, true)),
                      Row(
                        children: [
                          Container(
                            height: 20, // You can adjust the size
                            width: 20,
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              child: TextFormField(
                                controller: _destController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Add Dest'),
                                onFieldSubmitted: (value) =>
                                    _onSubmit(value, false),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
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
                      } else {
                        _addMarker(tappedPoint, 1);
                      }
                    },
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
                      const SizedBox(),
                      const Text(
                        'Steps 1/5',
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
                                  builder: (_) => PublishRideScreen2(
                                        source: _srcController.text,
                                        destination: _destController.text,
                                      )));
                            },
                            icon: const Icon(Icons.arrow_forward)),
                      )
                    ],
                  ),
                )
              ],
            ),
      const Center(child: Text('Messages')),
      const Center(child: Text('Profile')),
    ];

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
      body: screens[selectedIdx],
    );
  }
}

Widget _buildDottedStoppage(Color color, bool isTerminal,
    TextEditingController controller, Function(String) onSubmit) {
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
                onFieldSubmitted: onSubmit,
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
