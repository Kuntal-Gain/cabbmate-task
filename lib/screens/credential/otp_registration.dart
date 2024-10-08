import 'package:cabmate_task/screens/credential/name_registration.dart';
import 'package:cabmate_task/utils/snackbar.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String phone_number;
  final String otp;

  // ignore: non_constant_identifier_names
  const OtpScreen({super.key, required this.phone_number, required this.otp});

  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "What's the code?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Enter the code sent to ${widget.phone_number}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter OTP';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Handle retry functionality here
                  },
                  child: const Text(
                    "Retry",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Add some space before the button
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          // Proceed with OTP verification logic
          if (widget.otp == _otpController.text) {
            successBar(context, "OTP verified Successfully");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => NameScreen(
                          phone: widget.phone_number,
                        )));
          } else {
            failureBar(context, "Enter a Valid OTP");
            _otpController.clear();
          }
        },
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
