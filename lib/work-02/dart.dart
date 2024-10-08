// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class project extends StatefulWidget {
  const project({super.key});

  @override
  State<project> createState() => _projectState();
}

class _projectState extends State<project> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Expanded(
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              SizedBox(
                width: 80,
              ),
              Text(
                "Ride Details",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 90,
              ),
              Icon(Icons.call),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Documents',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Card(
                  child: SizedBox(
                height: 10,
              )),
              Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Address Proof',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        width: 210,
                        height: 10,
                      ),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Driving Licence',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        height: 1,
                      ),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Vehicle Documents',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            width: 140,
                          ),
                          Icon(Icons.arrow_forward_ios_outlined),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Card(
                    child: Row(
                      children: [
                        Text(
                          'Vehicle Insurance',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 170,
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                  const Card(
                      child: SizedBox(
                    height: 10,
                  )),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("Passenger Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.black,
                            width: 1), // Dark border color and width
                        borderRadius: BorderRadius.circular(
                            10), // Optional: Border radius for rounded corners
                      ),
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.person,
                                    size: 40, // Icon size
                                    color: Colors.white, // Icon color
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Text("Emma Brown",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 120,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.phone_in_talk_outlined,

                                            size: 20, // Icon size
                                            color: Colors.white, // Icon color
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 150),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Payment Mode:",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          "Card",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 68.0),
                                    child: Text(
                                      'You will get Created by the Adwin.',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                            height: 10,
                          ),
                          const Row(
                            children: [
                              SizedBox(
                                width: 7,
                              ),
                              Icon(Icons.groups),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "1 Passenger(s)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                width: 110,
                              ),
                              Icon(
                                Icons.currency_pound_sharp,
                                color: Colors.blue,
                              ),
                              Text(
                                "4.20",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.info_outline,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Waiting for your approval",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 9.0),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(170, 50),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.black, width: 2),

                                          borderRadius:
                                              BorderRadius.circular(12),

                                          // Rounded corners radius
                                        ),
                                      ),
                                      child: const Text("Decline")),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(165, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        // Rounded corners radius
                                      ),
                                    ),
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(
                                        color:
                                            Colors.white60, // Custom text color
                                        fontSize: 13, // Custom font size
                                        fontWeight:
                                            FontWeight.bold, // Bold text
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25, width: 20),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Car Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Card(
                      child: Image.network(
                        'https://www.spinny.com/blog/wp-content/uploads/2023/03/Black-Mahindra-XUV700-jpg.webp',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
