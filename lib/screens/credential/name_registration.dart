// ignore_for_file: library_private_types_in_public_api

import 'package:cabmate_task/screens/credential/login_screen.dart';

import 'package:flutter/material.dart';

import 'email_registration.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key, required this.phone});

  final String phone;

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  // Method to validate and show dialog
  bool _validateAndSubmit() {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      // Show dialog if any field is empty
      _showErrorDialog("Please enter both your first name and last name.");
      return false;
    } else {
      // Proceed with your action when fields are valid
      // For example, navigate to the next page
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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What's your name?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
                child: const Text(
                  'Already Have Account? Login Here',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                )),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          if (_validateAndSubmit() == false) {
            _validateAndSubmit();
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EmailInputScreen(
                          name:
                              "${_firstNameController.text} ${_lastNameController.text}",
                          phone: widget.phone,
                        )));
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
