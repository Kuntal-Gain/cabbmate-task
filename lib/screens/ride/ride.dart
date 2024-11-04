import 'package:cabmate_task/screens/ride/rides_details.dart';
import 'package:cabmate_task/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../service/firebase_service.dart';
import '../../utils/ride.dart';
import 'package:flutter_datetime_format/flutter_datetime_format.dart' as fd;

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key, required this.time, required this.number});
  final Timestamp time;
  final int number;

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  List<Ride> rides = [];

  @override
  void initState() {
    super.initState();
    fetchRides();
  }

  void fetchRides() async {
    setState(() {
// Set loading to true before fetching data
    });

    List<Ride> items = await FirebaseService().getAllRides();

    setState(() {
      rides = items.where((item) => item.noOfPassenger > 0).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Rides',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: ListView.builder(
        itemCount: rides.length,
        itemBuilder: (ctx, idx) {
          final ride = rides[idx];

          return FutureBuilder(
              future: FirebaseService().fetchUser(ride.uid),
              builder: (ctx, snap) {
                var riderData = snap.data;

                if (snap.connectionState == ConnectionState.waiting) {}

                if (snap.hasError) {
                  failureBar(context, "Something Went Wrong");
                }

                return rideCard(context, ride, riderData);
              });
        },
      ),
    );
  }

  Widget rideCard(
      BuildContext context, Ride ride, Map<String, dynamic>? riderData) {
    // Get device width for responsive design
    final deviceWidth = MediaQuery.of(context).size.width;
    // Store the values in variables for easy reference
    const cardElevation = 3.0;
    const cardMargin = EdgeInsets.symmetric(vertical: 8.0);
    const borderRadiusValue = 20.0;
    final boxShadowColor = Colors.grey.shade200;
    const boxShadowSpreadRadius = 3.0;
    const boxShadowBlurRadius = 3.0;
    const containerMargin = EdgeInsets.only(left: 10, right: 10, bottom: 12);
    const cardPadding = EdgeInsets.all(5.0);
    final imageSize = deviceWidth * 0.12; // Responsive image size
    const imageRadius = 20.0;
    const fontSizeName = 16.0;
    const fontSizeRideNo = 15.0;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                RideDetailsScreen(ride: ride, number: widget.number),
          ),
        );
      },
      child: Container(
        margin: containerMargin,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: boxShadowColor,
              spreadRadius: boxShadowSpreadRadius,
              blurRadius: boxShadowBlurRadius,
            )
          ],
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
        child: Card(
          elevation: cardElevation,
          margin: cardMargin,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          child: Padding(
            padding: cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                  child: Text(
                    'Ride No: ${ride.rideId}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: fontSizeRideNo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(imageRadius),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          riderData != null &&
                                  riderData['image'] != null &&
                                  riderData['image'].toString().isNotEmpty
                              ? riderData['image']
                              : 'https://cdn-icons-png.flaticon.com/512/4140/4140048.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ride.driverName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            ride.noOfPassenger.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                locationInfo('Start Location', ride.startLoc,
                    '${ride.startTime.toDate().hour}:${ride.startTime.toDate().minute.toString().padLeft(2, '0')} ${ride.startTime.toDate().hour < 12 ? 'AM' : 'PM'}'),
                const SizedBox(height: 10),
                locationInfo('End Location', ride.endLoc,
                    '${ride.endTime.toDate().hour}:${ride.endTime.toDate().minute.toString().padLeft(2, '0')} ${ride.endTime.toDate().hour < 12 ? 'AM' : 'PM'}'),
                const SizedBox(height: 5),
                Divider(
                  thickness: 2,
                  color: Colors.grey.shade400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        fd.FLDateTime.formatWithNames(
                                ride.startTime.toDate(), 'EEE, MMMM DD, YYYY')
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis, // Prevents overflow
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${ride.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          overflow:
                              TextOverflow.ellipsis, // Prevents price overflow
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 130.0),
                          child: Text(
                            'Per Passenger',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Prevents "Per Passenger" overflow
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget locationInfo(String label, String location, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: Colors.green),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                location,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
