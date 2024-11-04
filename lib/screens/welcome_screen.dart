import 'package:cabmate_task/screens/credential/phonenumber_registration.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Variables for the dropdown selections
  String selectedValue1 = 'EN';
  String selectedValue2 = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Align items in the row
              children: [
                Image.asset('assets/images/logo.jpg', height: 100),
                Row(
                  children: [
                    // First Dropdown
                    Container(
                      height: 40,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.blue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            value: selectedValue1,
                            items: <String>['EN', 'HI']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue1 = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // First Dropdown
                    Container(
                      height: 40,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.blue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            value: selectedValue2,
                            items: <String>['USD', 'INR', 'JPY']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: value == selectedValue1
                                        ? Colors.blue
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue2 = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20), // Add some space
            Image.network(
                'https://img.freepik.com/free-vector/mobile-taxi-app-concept_23-2148481945.jpg'),
            const Spacer(), // Pushes the next button to the bottom

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      iconSize: 40, // You can adjust the size
                      color: Colors.white,

                      onPressed: () {
                        // Define the action for the next button
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const MobileNumberScreen()));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
