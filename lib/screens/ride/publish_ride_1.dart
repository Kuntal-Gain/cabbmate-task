import 'package:flutter/material.dart';

class PublishRideScreen1 extends StatefulWidget {
  const PublishRideScreen1({super.key});

  @override
  State<PublishRideScreen1> createState() => _PublishRideScreen1State();
}

class _PublishRideScreen1State extends State<PublishRideScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('data'),
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
