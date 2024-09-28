import 'package:cabmate_task/screens/ride/ride.dart';
import 'package:flutter/material.dart';

class SearchRides extends StatefulWidget {
  const SearchRides({super.key});

  @override
  State<SearchRides> createState() => _SearchRidesState();
}

class _SearchRidesState extends State<SearchRides> {
  final _srcController = TextEditingController();
  final _destController = TextEditingController();
  final _personController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xffc2c2c2)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // Adjust based on screen width
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      // Text field for location input
                      _buildDottedStoppage(Colors.blue, true, _srcController),
                      Row(
                        children: [
                          Container(
                            height: 20, // You can adjust the size
                            width: 20,
                            decoration: const BoxDecoration(
                                color: Colors.blue, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              decoration: BoxDecoration(
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
                      // Date selector label
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
                      // Date input field
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                // _showCalendar(context); // Calendar picker
                              },
                              child: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ),
                      // Person selector label
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
                          width: MediaQuery.of(context).size.width *
                              0.8, // Adjust based on screen size
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
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
                              // Handle the value change
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      // Search button
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => RidesScreen())),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
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
            ),
          ],
        ),
      ),
    );
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
                decoration: BoxDecoration(
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
            Expanded(
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
