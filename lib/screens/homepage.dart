import 'package:cabmate_task/Rides_RideDetails/my_ride_selection.dart';
import 'package:cabmate_task/screens/payment/payment_demo.dart';
import 'package:cabmate_task/screens/profile/profile.dart';
import 'package:cabmate_task/screens/ride/publish_ride.dart';
import 'package:cabmate_task/screens/ride/publish_ride_2.dart';
import 'package:cabmate_task/screens/ride/search_rides.dart';
import 'package:cabmate_task/screens/ride/trip_screen.dart';
import 'package:cabmate_task/service/notification_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  int selectedIdx = 0;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    _notificationService.initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      SearchRides(),
      MyRidesScreen(),
      MyRidesScreen(),
      const ProfileScreen(),
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
