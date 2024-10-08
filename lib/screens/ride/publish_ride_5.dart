import 'package:cabmate_task/screens/homepage.dart';
import 'package:flutter/material.dart';

class PublishRide5 extends StatefulWidget {
  const PublishRide5({super.key});

  @override
  State<PublishRide5> createState() => _PublishRide5State();
}

class _PublishRide5State extends State<PublishRide5> {
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
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Review",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        const Text('Verify Documents',
                            style: TextStyle(fontSize: 16)),
                        verifyTiles('Address Proof'),
                        verifyTiles('Driving License'),
                        verifyTiles('Vehicle Document'),
                        verifyTiles('Vechicle Incentive'),

                        // phone number
                      ],
                    ),
                  ),
                ],
              ),
              const ListTile(
                title: Text(
                  "Ride Plan",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Tue, 19th Sep 23",
                  style: TextStyle(color: Colors.black45),
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
                            const Icon(Icons.radio_button_checked,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  'Steps 5/5',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const HomePage()));
                    },
                    child: const Center(
                        child: Text(
                      'Publish',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget verifyTiles(String type) {
  return Container(
    height: 50,
    margin: const EdgeInsets.all(5),
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(type),
        IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
      ],
    ),
  );
}
