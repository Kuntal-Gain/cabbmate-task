import 'package:cabmate_task/work-02/AddContactsScreen.dart';
import 'package:flutter/material.dart';

class Fifth extends StatelessWidget {
  const Fifth({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmergencyContactsScreen(),
    );
  }
}

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Emergency Contacts',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Phone Icon
            const Icon(
              Icons.add_call,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'For Your Safety',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Send alert to your near ones in case of an emergency.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please add them to your emergency contacts.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w800),
            ),
            const Spacer(),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddContactsScreen()),
                  );

                  // Add contacts functionality
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide.none,
                  minimumSize:
                      const Size(double.infinity, 50), // Full-width button
                ),
                child: const Text('Add Contacts'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
