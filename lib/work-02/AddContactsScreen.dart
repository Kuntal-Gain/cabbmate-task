// ignore_for_file: file_names

import 'package:cabmate_task/work-02/fifth.dart';
import 'package:flutter/material.dart';

class AddContactsScreen extends StatefulWidget {
  const AddContactsScreen({super.key});

  @override
  State<AddContactsScreen> createState() => _AddContactsScreenState();
}

class _AddContactsScreenState extends State<AddContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Emergency Contacts",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter your name", // Label for the text field
                  hintText: "", // Placeholder text
                  prefixIcon: const Icon(Icons.person), // Icon before the input
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Fifth()),
                      );
                    },
                    child: const Icon(Icons.clear), // Icon with tap event
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded border
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  filled: true, // Enable background color
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter your name", // Label for the text field
                  hintText: "", // Placeholder text
                  prefixIcon: const Icon(Icons.person), // Icon before the input
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Fifth()),
                      );
                    },
                    child: const Icon(Icons.clear), // Icon with tap event
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded border
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  filled: true, // Enable background color
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 475),
              const Text(
                'You can add maximum 5 contacts.',
                style: TextStyle(fontSize: 14, color: Colors.blueAccent),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: OutlinedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: BorderSide.none,
                    minimumSize:
                        const Size(double.infinity, 50), // Full-width button
                  ),
                  child: const Text('Add Contacts'),
                ),
              ),
            ]),
          ),
        ));
  }
}
