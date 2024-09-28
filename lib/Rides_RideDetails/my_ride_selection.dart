import 'package:flutter/material.dart';

class MyRidesScreen extends StatefulWidget {
  @override
  _MyRidesScreenState createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen>
    with TickerProviderStateMixin {
  // Defining all the text variables to be used in the UI
  final String bookingNo = 'Booking No. #1904465218';
  final String driverName = 'Robert';
  final String driverStatus = 'Driver Arriving';
  final String startLocation =
      'Block-A, Mondeal Square, Prahlad Nagar,\nAhmedabad, Gujarat 380015, India';
  final String startTime = '11:00 AM';
  final String endLocation =
      '41, Science City, Sola,\nAhmedabad,Gujarat 380060, India';
  final String endTime = '11:08 AM';
  final String trackDriver = 'Track Driver';
  final String trackDriver1 = 'Start Trip';
  final String price = '\$4.00';
  final String date = 'Tue, 19th Sep 23';
  final String perPassenger = 'Per Passenger';

  int _currentIndex =
      1; // Variable to track the current bottom navigation index
  late TabController _tabController; // TabController to control TabBarView

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to handle responsive design
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('My Rides', style: TextStyle(color: Colors.black)),
        bottom: TabBar(
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(color: Colors.black),
          controller: _tabController,
          tabs: [
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
      body: TabBarView(
        controller: _tabController,
        children: [
          buildPublishedRideContent(mediaQuery),
          buildBookedRideContent(mediaQuery),
        ],
      ),
    );
  }

  // Initial Selected Value
  String dropdownvalue = 'In process';

  // List of items in our dropdown menu
  var items = [
    'In process',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  var driverStatus1 = "Start Trip";

  // Function to build the content for Booked Ride
  Widget buildBookedRideContent(Size mediaQuery) {
    return SingleChildScrollView(
      child: Container(
        height: 500,
        margin: EdgeInsets.only(top: 6, left: 4, right: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(mediaQuery.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
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
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  children: [
                    Text(bookingNo,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: mediaQuery.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Container(
                              width: 60,
                              height: 60,
                              child: Image.network(
                                "https://i.postimg.cc/mkFpcLtQ/images.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(width: mediaQuery.width * 0.01),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(driverName,
                                style: TextStyle(
                                    fontSize: mediaQuery.width * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaQuery.width * 0.03,
                                  vertical: mediaQuery.height * 0.005),
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(driverStatus,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: mediaQuery.width * 0.035)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mediaQuery.height * 0.02),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Start Location",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Text(startLocation,
                                  style: TextStyle(color: Colors.grey)),
                            ),
                          ],
                        ),
                        Text(startTime,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: mediaQuery.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("End Location",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Text(endLocation,
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        Text(endTime,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Spacer(),
                    SizedBox(height: mediaQuery.height * 0.02),
                    Center(
                      child: Container(
                        width: 210,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {},
                          child: Text(trackDriver,
                              style: TextStyle(
                                  fontSize: mediaQuery.width * 0.045,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(date,
                                style: TextStyle(color: Colors.black)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(price,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: mediaQuery.width * 0.045)),
                              ),
                              Text(perPassenger,
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Initial Selected Value
  String dropdownvalues = 'Upcoming';

  // List of items in our dropdown menu
  var itemss = [
    'Upcoming',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  // Function to build the content for Published Ride
  Widget buildPublishedRideContent(Size mediaQuery) {
    return SingleChildScrollView(
      child: Container(
        height: 500,
        margin: EdgeInsets.only(top: 6, left: 4, right: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(mediaQuery.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 160),
                child: DropdownButton(
                  value: dropdownvalues,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: itemss.map((String itemss) {
                    return DropdownMenuItem(
                      value: itemss,
                      child: Text(itemss),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalues = newValue!;
                    });
                  },
                ),
              ),
              Text(bookingNo, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: mediaQuery.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: Image.network(
                          "https://i.postimg.cc/mkFpcLtQ/images.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: mediaQuery.width * 0.01),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(driverName,
                          style: TextStyle(
                              fontSize: mediaQuery.width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: mediaQuery.width * 0.03,
                            vertical: mediaQuery.height * 0.005),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(driverStatus1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: mediaQuery.width * 0.035)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.02),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Start Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: Text(startLocation,
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                    ),
                    Text(startTime,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.02),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("End Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(endLocation, style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Text(endTime,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(height: mediaQuery.height * 0.02),
              Center(
                child: Container(
                  width: 210,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {},
                    child: Text(trackDriver1,
                        style: TextStyle(
                            fontSize: mediaQuery.width * 0.045,
                            color: Colors.white)),
                  ),
                ),
              ),
              Container(
                width: 350,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child:
                            Text(date, style: TextStyle(color: Colors.black)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(price,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: mediaQuery.width * 0.045)),
                          ),
                          Text(perPassenger,
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
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
