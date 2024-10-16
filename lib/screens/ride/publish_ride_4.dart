import 'dart:math';

import 'package:cabmate_task/screens/ride/publish_ride_5.dart';
import 'package:cabmate_task/utils/ride.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../utils/country.dart';

class PublishRideScreen4 extends StatefulWidget {
  const PublishRideScreen4(
      {super.key,
      required this.stops,
      required this.time,
      required this.passengers,
      required this.price});

  final List<String> stops;
  final DateTime time;
  final int passengers;
  final double price;

  @override
  State<PublishRideScreen4> createState() => _PublishRideScreen4State();
}

class _PublishRideScreen4State extends State<PublishRideScreen4> {
  String selectedCode = codes[0].code;

  // controllers
  final _driverController = TextEditingController();
  final _driverContactController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _numberController = TextEditingController();
  final _colorController = TextEditingController();

  String generateRideId() {
    // Generate a random 6-digit number (because "CM" is already 2 characters)
    Random random = Random();
    int randomNumber =
        100000 + random.nextInt(900000); // Ensures it's a 6-digit number

    return "CM$randomNumber";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Publish Ride',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // driver's details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Driver Details',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffc2c2c2),
                        spreadRadius: 2,
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // driver
                      const Text('Driver Name*',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffc2c2c2),
                                spreadRadius: 2,
                                blurRadius: 2,
                              )
                            ]),
                        child: Expanded(
                          child: TextField(
                            controller: _driverController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'eg. Jhon Doe'),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // phone number
                      const Text("Driver's Contact No.*",
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xffc2c2c2),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    DropdownButton<String>(
                                      value:
                                          selectedCode, // Currently selected code
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      underline: Container(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCode = newValue!;
                                        });
                                      },
                                      items: codes
                                          .map<DropdownMenuItem<String>>(
                                              (CountryCode country) {
                                        return DropdownMenuItem<String>(
                                          value: country
                                              .code, // Set the value to the country code
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Image.network(country
                                                    .flag), // Show the country flag
                                              ),
                                              const SizedBox(width: 5),
                                              Text(country
                                                  .code), // Show the country code
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "|",
                                      style: TextStyle(
                                          fontSize: 35, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  controller: _driverContactController,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: '2586543570',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Car details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Car Details',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffc2c2c2),
                        spreadRadius: 2,
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // driver
                      const Text('Brand Name*', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffc2c2c2),
                                spreadRadius: 2,
                                blurRadius: 2,
                              )
                            ]),
                        child: Expanded(
                          child: TextField(
                            controller: _brandController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'eg. Nissan'),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // driver
                          const Text('Model*', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffc2c2c2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                  )
                                ]),
                            child: Expanded(
                              child: TextField(
                                controller: _modelController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'eg. XY123'),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // driver
                          const Text("Car's Number Plate",
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffc2c2c2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                  )
                                ]),
                            child: Expanded(
                              child: TextField(
                                controller: _numberController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'eg. 12345XYZ'),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // driver
                          const Text('Color*', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffc2c2c2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                  )
                                ]),
                            child: Expanded(
                              child: TextField(
                                controller: _colorController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'eg. Black'),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Navigation Buttons
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
                    'Steps 4/5',
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PublishRide5(
                                ride: Ride(
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                    rideId: generateRideId(),
                                    rideModel: _modelController.text,
                                    rideNameplate: _numberController.text,
                                    rideImg: '',
                                    color: _colorController.text,
                                    driverImg: '',
                                    driverName: _driverController.text,
                                    driverNumber: _driverContactController.text,
                                    startLoc: widget.stops[0],
                                    endLoc:
                                        widget.stops[widget.stops.length - 1],
                                    startTime: Timestamp.fromDate(widget.time),
                                    endTime: Timestamp.fromDate(
                                        widget.time.add(Duration(minutes: 30))),
                                    price: widget.price,
                                    noOfPassenger: widget.passengers,
                                    brand: _brandController.text),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
