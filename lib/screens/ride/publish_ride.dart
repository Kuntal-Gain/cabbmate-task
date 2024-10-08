import 'package:cabmate_task/screens/ride/publish_ride_1.dart';
import 'package:cabmate_task/utils/navigator.dart';
import 'package:flutter/material.dart';

class PublishRideScreen extends StatefulWidget {
  const PublishRideScreen({super.key});

  @override
  State<PublishRideScreen> createState() => _PublishRideScreenState();
}

class _PublishRideScreenState extends State<PublishRideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            toNavigate(context, const PublishRideScreen1());
          },
          child: const Text("Search"),
        ),
      ),
    );
  }
}
