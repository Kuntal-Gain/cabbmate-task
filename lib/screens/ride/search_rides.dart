import 'package:cabmate_task/screens/ride/ride.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchRides extends StatefulWidget {
  const SearchRides({super.key});

  @override
  State<SearchRides> createState() => _SearchRidesState();
}

class _SearchRidesState extends State<SearchRides> {
  final _srcController = TextEditingController();
  final _destController = TextEditingController();
  int totalMembs = 0;
  DateTime _dateTime = DateTime.now();

  Future<void> _selectDateTime() async {
    // Show Date Picker
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime.isBefore(DateTime.now())
          ? DateTime.now()
          : _dateTime, // Ensure initialDate is today or later
      firstDate: DateTime.now(), // firstDate is today
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      // Show Time Picker
      TimeOfDay? selectedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay(hour: _dateTime.hour, minute: _dateTime.minute),
      );

      if (selectedTime != null) {
        setState(() {
          _dateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        // Add SingleChildScrollView here
        child: Column(
          children: [
            Center(
              child: Container(
                height: 350,
                width: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/splash.jpg',
                      ),
                    ),
                    const Positioned(
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Find and Book Rides at\n Low Prices',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffc2c2c2)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildDottedStoppage(Colors.blue, true, _srcController),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _destController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add Dest'),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28, right: 10),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: DateFormat('yyyy-MM-dd HH:mm a')
                              .format(_dateTime),
                          suffixIcon: InkWell(
                            onTap: _selectDateTime,
                            child: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0, top: 10),
                      child: Row(
                        children: [
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
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: DropdownButton<int>(
                          isExpanded: true,
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
                          value: totalMembs == 0 ? null : totalMembs,
                          items: List.generate(4, (index) {
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
                              totalMembs = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => RidesScreen(
                                time: Timestamp.fromDate(_dateTime),
                                number: totalMembs,
                              ))),
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
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
    ));
  }

  Widget _buildDottedStoppage(
      Color color, bool isTerminal, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Container above the dotted line
        Row(
          children: [
            Container(
              height: 20, // You can adjust the size
              width: 20,
              decoration: BoxDecoration(
                color: color, // Color of the container
                shape: isTerminal
                    ? BoxShape.circle
                    : BoxShape.rectangle, // Shape of the container (circle)
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: isTerminal ? 'Add Source' : 'Any Stop'),
                ),
              ),
            ),
          ],
        ),

        // Dotted line below the container
        Row(
          children: [
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0), // space between dots
                  child: Container(
                    height: 4, // size of each dot
                    width: 4,
                    decoration: const BoxDecoration(
                      color: Colors.grey, // dot color
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Divider(),
              ),
            )
          ],
        ),
      ],
    );
  }
}
