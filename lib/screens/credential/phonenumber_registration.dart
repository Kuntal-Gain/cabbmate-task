import 'dart:math';

import 'package:flutter/material.dart';

import '../../service/api_service.dart';
import 'otp_registration.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MobileNumberScreen(),
    );
  }
}

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final _mobileNumberController = TextEditingController();
  String _selectedCountryCode = '+91'; // Default country code
  String otp = "";

  // List of country codes
  final List<String> _countryCodes = ['+91', '+1', '+44', '+61'];

  // Method to validate and show dialog
  bool _validateAndSubmit() {
    String mobileNumber = _mobileNumberController.text.trim();

    if (mobileNumber.isEmpty) {
      // Show dialog if mobile number is empty
      _showErrorDialog("Please enter your mobile number.");
      return false;
    } else if (mobileNumber.length != 10) {
      _showErrorDialog("You entered an invalid number.");
      return false;
    } else {
      // Proceed with your action when fields are valid
      return true;
    }
  }

  // Method to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Input Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String generateOtp() {
    var random = Random();
    int otp = 100000 +
        random.nextInt(900000); // Generates a number between 100000 and 999999
    return otp.toString();
  }

  @override
  void initState() {
    otp = generateOtp();
    super.initState();
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      // Prevent overflow when the keyboard is shown
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        // Make the content scrollable
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter your mobile number",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  DropdownButton<String>(
                    value: _selectedCountryCode,
                    items: _countryCodes.map((String code) {
                      return DropdownMenuItem<String>(
                        value: code,
                        child: Text(code),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountryCode = newValue!;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _mobileNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Mobile',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  // Handle other login options action
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Or choose other login options ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        child: Container(
                            margin: const EdgeInsets.only(top: 5, left: 4),
                            child: const Icon(Icons.arrow_forward)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: "By proceeding, I accept the ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms and Conditions & Privacy Policy",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          final message = "Your Cabbmate Verification code is $otp";
          final ph = _selectedCountryCode + _mobileNumberController.text;
          bool store = _validateAndSubmit();
          if (store == false) {
            _validateAndSubmit();
          } else {
            ApiService().sendSms(ph, message);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  phone_number: _mobileNumberController.text.toString(),
                  otp: otp,
                ),
              ),
            );
          }
        },
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
