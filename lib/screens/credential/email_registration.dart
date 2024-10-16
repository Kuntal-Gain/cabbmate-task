// ignore_for_file: use_build_context_synchronously

import 'package:cabmate_task/screens/homepage.dart';
import 'package:cabmate_task/service/firebase_service.dart';
import 'package:cabmate_task/utils/snackbar.dart';
import 'package:cabmate_task/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({super.key, required this.name, required this.phone});

  final String name;
  final String phone;

  @override
  // ignore: library_private_types_in_public_api
  _EmailInputScreenState createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _emailController = TextEditingController();
  final _passwordContreoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showError = false;

  // Email validation function
  // ignore: unused_element
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    // Regex for basic email validation
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    // Listener to clear error message when the user starts typing
    _emailController.addListener(() {
      if (_showError) {
        setState(() {
          _showError = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "What's your email & Password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'emma.brown@demo.com',
                  border: const UnderlineInputBorder(),
                  errorText: _showError
                      ? 'Enter a valid email address'
                      : null, // Dynamic error message display
                ),
                keyboardType: TextInputType.emailAddress,
                // We will manually trigger the validation below instead of using a validator
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordContreoller,
                decoration: InputDecoration(
                  labelText: 'Password',

                  border: const UnderlineInputBorder(),
                  errorText: _showError
                      ? 'Enter a valid Password'
                      : null, // Dynamic error message display
                ),
                keyboardType: TextInputType.text,
                // We will manually trigger the validation below instead of using a validator
              ),
              const Spacer(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () async {
          try {
            // Sign up the user
            User? user = await FirebaseService()
                .signUp(_emailController.text, _passwordContreoller.text);

            if (user != null) {
              final uid = user.uid;

              // Create user in Firestore
              FirebaseService()
                  .createUser(
                uid,
                UserModel(
                  uid: uid,
                  name: widget.name,
                  email: _emailController.text,
                  image: "",
                  wallet: 10,
                  number: widget.phone,
                  bookedRides: [],
                  publishedRides: [],
                ),
              )
                  .then((_) {
                // ignore: duplicate_ignore
                // ignore: use_build_context_synchronously
                successBar(context, "Signup Successful");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const HomePage(
                      selectedIdx: 0,
                    ),
                  ),
                );
              }).catchError((error) {
                failureBar(context, "Failed to create user: $error");
              });
            } else {
              failureBar(context, "Signup failed. Please try again.");
            }
          } catch (e) {
            failureBar(context, "Signup failed: $e");
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
    _emailController.dispose();
    super.dispose();
  }
}
