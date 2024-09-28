import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: documentss(),
  ));
}

class documentss extends StatelessWidget {
  RxInt valuess = 1.obs;

  documentss({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Publish a Ride ",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.grey.shade100,
                  width: 400,
                  height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 74.0),
                        child: Text(
                          " Verify Documents",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        width: 350,
                        margin: EdgeInsets.all(6),
                        child: const Card(
                          elevation: 12,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    title: Text(
                                      "Address Proof",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    trailing: Icon(Icons.edit),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Card(
                                  elevation: 5, // Elevation set to 5
                                  child: ListTile(
                                    title: Text(
                                      'Driving License',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    trailing: Icon(Icons.edit), // Pencil icon
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Card(
                                  elevation: 5, // Elevation set to 5
                                  child: ListTile(
                                    title: Text(
                                      'Vechile Document',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    trailing: Icon(Icons.edit), // Pencil icon
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Card(
                                  elevation: 5, // Elevation set to 5
                                  child: ListTile(
                                    title: Text(
                                      'Vechile Insurance',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    trailing: Icon(Icons.edit), // Pencil icon
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
              ),
            ),
            const ListTile(
              title: Text(
                "Ride Plan",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Tue, 19th Sep 23",
                style: TextStyle(color: Colors.black45),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Container(
                margin: EdgeInsets.only(left: 3, right: 3),
                child: const Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Start Location ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        "11:00 AM",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                      subtitle: Text(
                        'Block-A, Mondeal Square, Prahlad Nagar, Ahmedabad, Gujarat 380015, India',
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black45,
                    ),
                    ListTile(
                      title: Text(
                        "End Location ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        "11:08 AM",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                      subtitle: Text(
                        '41, Science City, Sola, Ahmedabad, Gujarat 380060, India',
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                height: 80,
                color: Colors.blue, // Background color
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          if (valuess < 5) {
                            valuess++;
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                              width: 35,
                              height: 35,
                              color: Colors.white,
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black)),
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        'Step ${valuess.value}/ 5',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.white, // Text color
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                      ),
                      child: Text(
                        'Publish Ride',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {},
        items: [
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
