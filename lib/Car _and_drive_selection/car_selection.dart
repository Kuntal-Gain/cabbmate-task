// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideDetailsPage extends StatefulWidget {
  const RideDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RideDetailsPageState createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends State<RideDetailsPage> {
  // Example data for the ride
  String carImage =
      'https://i.postimg.cc/3JdKwRnQ/curvv-exterior-right-front-three-quarter.webp'; // Network image URL
  String carBrand = 'Nissan';
  String carModel = 'Versa - Black';
  String driverName = 'Robert Smith';
  String driverPhone = '+12586456370';
  String additionalNotes = 'Nissan black';
  double totalPrice = 4.00;
  String car_number = "NY46G3865";

  var price = "\$4.00";
  @override
  Widget build(BuildContext context) {
    // MediaQuery to get the screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    var numbers = 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the app bar color
        title: const Text(
          'Ride Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [Icon(Icons.phone_enabled)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
            screenWidth * 0.04), // Dynamic padding based on screen width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Details Section
            Text(
              'Car Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.05, // Font size based on screen width
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // Dynamic vertical space
            Container(
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight *
                        0.25, // Image height is 25% of screen height
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(carImage, fit: BoxFit.cover),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 13.0),
                        child: Text(
                          carBrand,
                          style: TextStyle(
                            fontSize: screenWidth *
                                0.045, // Font size based on screen width
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.car_rental,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              carModel,
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.045, // Font size based on screen width
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.card_travel_rounded,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              car_number,
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.045, // Font size based on screen width
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // Dynamic vertical space
            // Driver Details Section

            // Total Price Section

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Price",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("For $numbers passengers"),
                      Divider(
                        color: Colors.grey.shade400,
                        thickness: 2,
                      )
                    ],
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(color: Colors.blue),
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.07), // Extra spacing
            // Continue Button
            ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar("Continue", "Proceeding to the next step");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, screenHeight * 0.07),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
