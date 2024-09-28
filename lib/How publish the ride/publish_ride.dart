import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class SearchRide extends StatefulWidget {
  @override
  State<SearchRide> createState() => _SearchRideState();
}

class _SearchRideState extends State<SearchRide> {
  final Rx<TextEditingController> calender = TextEditingController().obs;
  int? _selectedNumber;

  void _showCalendar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Dialog(
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              onDaySelected: (selectedDay, focusedDay) {
                String formattedDate =
                    DateFormat('d MMMM yyyy').format(selectedDay);
                calender.value.text = formattedDate;
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pre-setting the date in the text field
    calender.value.text = "19 Sep 2023";

    // Get the screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth, // Use full screen width
        height: screenHeight, // Use full screen height
        child: Stack(
          children: [
            // Background image container
            Container(
              width: screenWidth, // Set to screen width
              height: screenHeight * 0.3, // Adjust based on screen height
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/backgroundimage.PNG"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Header text
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Center(
                child: Text(
                  "Find and Book Rides at\nLow Prices",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center, // Align text in the center
                ),
              ),
            ),
            // Main content container
            Positioned(
              top: screenHeight * 0.25, // Adjust based on screen height
              left: screenWidth * 0.05, // Set dynamically
              child: Container(
                width:
                    screenWidth * 0.9, // Set dynamically based on screen size
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    // Text field for location input
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter Your Location",
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 8),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter Destination",
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    // Date selector
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0, top: 15),
                      child: Row(
                        children: [
                          Text(
                            "Select Date",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.star,
                            size: 17,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Obx(
                        () => TextField(
                          controller: calender.value,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                _showCalendar(context);
                              },
                              child: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Person selector
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10),
                      child: Row(
                        children: const [
                          Text(
                            "Person",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Icon(Icons.star, color: Colors.red, size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Dropdown for selecting number of persons
                    Center(
                      child: Container(
                        width: screenWidth * 0.8, // Adjust based on screen size
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            isExpanded: true,
                            value: _selectedNumber,
                            hint: const Text(
                              "Select a number",
                              style: TextStyle(color: Colors.black),
                            ),
                            dropdownColor: Colors.white,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 45,
                            ),
                            items: List.generate(10, (index) {
                              int number = index + 1;
                              return DropdownMenuItem<int>(
                                value: number,
                                child: Text(
                                  number.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }),
                            onChanged: (value) {
                              setState(() {
                                _selectedNumber = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Search button
                    Container(
                      width: screenWidth * 0.8, // Adjust based on screen size
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your search functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Search',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }
}
