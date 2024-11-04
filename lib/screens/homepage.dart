import 'package:cabmate_task/screens/profile/profile.dart';
import 'package:cabmate_task/screens/ride/publish_ride_1.dart';
import 'package:cabmate_task/screens/ride/search_rides.dart';
import 'package:cabmate_task/service/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/firebase_service.dart';
import '../utils/user.dart';
import 'ride/my_rides.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.selectedIdx});
  final int selectedIdx;

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  late int selectedIdx;
  final NotificationService _notificationService = NotificationService();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseService srv = FirebaseService();
  UserModel? _user;

  @override
  void initState() {
    selectedIdx = widget.selectedIdx;
    _notificationService.initNotification();
    srv.fetchUser(uid).then((userData) {
      if (userData != null) {
        print('Fetched userData: $userData'); // Add this line for debugging
        if (mounted) {
          setState(() {
            _user =
                UserModel.fromJson(userData); // Converting Map to User object
          });
        }
      } else {
        print('Failed to fetch user data.'); // Add error logging
      }
    }).catchError((error) {
      print('Error fetching user data: $error'); // Handle any exceptions
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const SearchRides(),
      const PublishRideScreen1(),
      _user != null
          ? MyRidesScreen(user: _user!) // Check if _user is initialized
          : const Center(
              child:
                  CircularProgressIndicator()), // Show a loader until _user is initialized
      _user != null
          ? ProfileScreen(user: _user!) // Check if _user is initialized
          : const Center(
              child:
                  CircularProgressIndicator()), // Show a loader until _user is initialized
    ];

    return Scaffold(
      body: screens[selectedIdx],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            selectedIdx = val;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: selectedIdx == 0 ? Colors.blue : Colors.grey,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              color: selectedIdx == 1 ? Colors.blue : Colors.grey,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: selectedIdx == 2 ? Colors.blue : Colors.grey,
            ),
            label: 'My Rides',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: selectedIdx == 3 ? Colors.blue : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
