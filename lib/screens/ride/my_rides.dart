// ignore_for_file: use_key_in_widget_constructors

import 'package:cabmate_task/screens/ride/published_ride_details.dart';
import 'package:cabmate_task/screens/ride/trip_screen.dart';
import 'package:cabmate_task/service/firebase_service.dart';
import 'package:cabmate_task/utils/ride.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_format/flutter_datetime_format.dart' as fd;

import '../../models/requests.dart';
import '../../utils/user.dart';

class MyRidesScreen extends StatefulWidget {
  final UserModel user;

  const MyRidesScreen({super.key, required this.user});
  @override
  // ignore: library_private_types_in_public_api
  _MyRidesScreenState createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen>
    with TickerProviderStateMixin {
  int _currentIndex =
      0; // Variable to track the current bottom navigation index
  late TabController _tabController; // TabController to control TabBarView
  List<Ride> rides = [];
  bool _isLoading = true; // Variable to track loading state
  List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<Ride> bookedRides = [];
  List<Requests> requests = [];

  @override
  void initState() {
    super.initState();

    fetchRides();
    fetchBookedRides();
    fetchPublishedRidesWithRequests();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: _currentIndex);
  }

  void fetchRequests(String rideId) async {
    try {
      List<Requests> reqs = await FirebaseService().fetchRequests(rideId);

      setState(() {
        // Merge fetched requests with existing ones
        requests
            .addAll(reqs); // This adds the new requests to the existing list
        // Optionally filter for pending requests if needed
        // requests = requests.where((item) => item.status == "pending").toList();
      });
    } catch (e) {
      print("Error fetching requests: $e");
    }
  }

  void fetchPublishedRidesWithRequests() async {
    setState(() {
      _isLoading = true;
    });

    List<Ride> items = await FirebaseService().getAllRides();

    // Fetch requests for each published ride
    for (var ride in items) {
      if (ride.uid == FirebaseAuth.instance.currentUser!.uid) {
        fetchRequests(ride.rideId); // Await here
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void fetchRides() async {
    setState(() {
      _isLoading = true; // Set loading to true before fetching data
    });

    List<Ride> items = await FirebaseService().getAllRides();

    setState(() {
      rides = items
          .where((item) => item.uid == FirebaseAuth.instance.currentUser!.uid)
          .toList();
      _isLoading = false;
    });
  }

  void fetchBookedRides() async {
    setState(() {
      _isLoading = true;
    });

    // Convert the dynamic list to a List<String>
    List<String> rideIds = widget.user.bookedRides.cast<String>();

    List<Ride> items = await FirebaseService().fetchBookedRides(rideIds);

    setState(() {
      _isLoading = false;
      bookedRides = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to handle responsive design
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('My Rides', style: TextStyle(color: Colors.black)),
        bottom: TabBar(
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(color: Colors.black),
          controller: _tabController,
          tabs: const [
            Tab(text: 'Published Ride'),
            Tab(text: 'Booked Ride'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      body: _isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(), // Show progress indicator while loading
            )
          : TabBarView(
              controller: _tabController,
              children: [
                buildPublishedRideContent(mediaQuery, rides),
                buildBookedRideContent(mediaQuery, bookedRides),
              ],
            ),
    );
  }

  // Initial Selected Value
  String dropdownvalue = 'Pending';

  // List of items in our dropdown menu
  var items = ['Upcoming', 'Pending', 'Completed'];
  var driverStatus1 = "Start Trip";

  Widget buildBookedRideContent(Size mediaQuery, List<Ride> rides) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rides.length,
            itemBuilder: (context, index) {
              Ride ride = rides[index];

              return FutureBuilder<Map<String, dynamic>?>(
                future: FirebaseService().fetchUser(ride.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  var riderData = snapshot.data;
                  return Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffc2c2c2),
                          spreadRadius: 2,
                          blurRadius: 1,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking No. #${ride.rideId}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    riderData != null &&
                                            riderData['image'] != null &&
                                            riderData['image']
                                                .toString()
                                                .isNotEmpty
                                        ? riderData['image']
                                        : 'https://cdn-icons-png.flaticon.com/512/4140/4140048.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                riderData != null &&
                                        riderData['name'] != null &&
                                        riderData['name'].toString().isNotEmpty
                                    ? riderData['name']
                                    : "Unknown user",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.radio_button_checked,
                                    color: Colors.green),
                                SizedBox(width: 10),
                                Text(
                                  'Start Location',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              '${ride.startTime.toDate().hour}:${ride.startTime.toDate().minute.toString().padLeft(2, '0')} ${ride.startTime.toDate().hour < 12 ? 'AM' : 'PM'}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(10, (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 4,
                                    width: 2,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                ride.startLoc,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.radio_button_checked,
                                    color: Colors.red),
                                SizedBox(width: 10),
                                Text(
                                  'End Location',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              '${ride.endTime.toDate().hour}:${ride.endTime.toDate().minute.toString().padLeft(2, '0')} ${ride.endTime.toDate().hour < 12 ? 'AM' : 'PM'}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 25),
                            Flexible(
                              child: Text(
                                ride.endLoc,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => TripScreen(ride: ride),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Track Ride',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                fd.FLDateTime.formatWithNames(
                                        ride.startTime.toDate(),
                                        'EEE, MMMM DD, YYYY')
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$${ride.price}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const Text('Per Person'),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // Initial Selected Value
  String dropdownvalues = 'Upcoming';

  // List of items in our dropdown menu
  var itemss = ['Upcoming', 'Pending', 'Completed'];

  Widget buildPublishedRideContent(Size mediaQuery, List<Ride> rides) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: rides.length,
            itemBuilder: (context, index) {
              Ride ride = rides[index]; // Get the ride data at this index

              // Check if there are any requests for this ride
              var requestsForThisRide = requests
                  .where((request) =>
                      request.rideId == ride.rideId &&
                      request.status == "pending")
                  .toList();

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => PublishedRideDetails(ride: ride)));
                },
                child: Column(
                  children: [
                    Container(
                      height: 302,
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(left: 16, top: 16, right: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffc2c2c2),
                            spreadRadius: 2,
                            blurRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ride No. #${ride.rideId}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.radio_button_checked,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Start Location',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    '${ride.startTime.toDate().hour}:${ride.startTime.toDate().minute.toString().padLeft(2, '0')} ${ride.startTime.toDate().hour < 12 ? 'AM' : 'PM'}',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(10, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical:
                                                2.0), // space between dots
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          height: 4, // size of each dot
                                          width: 2, // width of the dotted line
                                          decoration: const BoxDecoration(
                                            color: Colors
                                                .grey, // color of the dots
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                      child: Text(
                                    ride.startLoc,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.radio_button_checked,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'End Location',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    // need update
                                    '${ride.endTime.toDate().hour}:${ride.endTime.toDate().minute.toString().padLeft(2, '0')} ${ride.endTime.toDate().hour < 12 ? 'AM' : 'PM'}',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 25),
                                  Flexible(
                                      child: Text(
                                    ride.startLoc,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                fd.FLDateTime.formatWithNames(
                                        ride.startTime.toDate(),
                                        'EEE, MMMM DD, YYYY')
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${ride.price}',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text('Per Person'),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (requestsForThisRide.isNotEmpty)
                      Container(
                        height: 30,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'You have a Pending Request',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
