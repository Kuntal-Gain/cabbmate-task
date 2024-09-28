import 'package:cabmate_task/screens/ride/booking_summary.dart';
import 'package:flutter/material.dart';

class RideDetailsScreen extends StatefulWidget {
  const RideDetailsScreen({super.key});

  @override
  _RideDetailsScreenState createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  final String startLocation =
      'Block-A, Mondeal Square, Prahlad Nagar, Ahmedabad, Gujarat 380015, India';
  final String endLocation =
      '41, Science City, Sola, Ahmedabad, Gujarat 380060, India';
  final String carModel = 'Nissan Versa';
  final String totalPrice = '\$4.00';
  final String rideTime = 'Tue, 19th Sep 23';
  final String startTime = '11:00 AM';
  final String endTime = '11:08 AM';
  String carImage =
      'https://imgd.aeplcdn.com/600x337/n/cw/ec/139651/curvv-exterior-right-front-three-quarter.jpeg?isig=0&q=80';
  String carBrand = 'Nissan';
  String carNumber = "NY46G3865";
  var numbers = 1;
  var price = "\$4.00";
  String driverName = 'Robert Smith';
  String driverPhone = '+12586456370';
  String additionalNotes = 'Nissan black';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Ride Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () {
              // Action for info button
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Scrollable section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Route Details
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Route Details',
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Start Location
                              Row(
                                children: [
                                  const Icon(Icons.radio_button_checked,
                                      color: Colors.green),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Start Location',
                                    style: TextStyle(
                                      fontSize: mediaQuery.width * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                startLocation,
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.04,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                startTime,
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.04,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // End Location
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.red),
                                  const SizedBox(width: 8),
                                  Text(
                                    'End Location',
                                    style: TextStyle(
                                      fontSize: mediaQuery.width * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                endLocation,
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.04,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                endTime,
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.04,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Ride Date and Price
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    rideTime,
                                    style: TextStyle(
                                      fontSize: mediaQuery.width * 0.045,
                                    ),
                                  ),
                                  Text(
                                    totalPrice,
                                    style: TextStyle(
                                      fontSize: mediaQuery.width * 0.045,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Car Details Section
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              carImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: mediaQuery.height * 0.25,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  carBrand,
                                  style: TextStyle(
                                    fontSize: mediaQuery.width * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.car_rental,
                                        color: Colors.black),
                                    const SizedBox(width: 8),
                                    Text(
                                      carModel,
                                      style: TextStyle(
                                        fontSize: mediaQuery.width * 0.045,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.card_travel_rounded,
                                        color: Colors.black),
                                    const SizedBox(width: 8),
                                    Text(
                                      carNumber,
                                      style: TextStyle(
                                        fontSize: mediaQuery.width * 0.045,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Driver Details
                    Text(
                      'Driver Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  width: 60,
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://i.postimg.cc/QdhmZWvp/360-F-243123463-z-Tooub557x-EWABDLk0j-Jkl-Dy-LSGl2jrr.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      driverName,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(width: 5),
                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            driverPhone,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.045,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Additional Notes: $additionalNotes',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // To make sure it doesn't take more space than needed
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Price",
                            style: TextStyle(
                              fontSize: mediaQuery.width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "For $numbers passengers",
                            style: TextStyle(
                              fontSize: mediaQuery.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.045,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action for continue button
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BookingSummary()));
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
