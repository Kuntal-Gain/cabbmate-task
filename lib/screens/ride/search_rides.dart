import 'package:flutter/material.dart';

class SearchRides extends StatelessWidget {
  const SearchRides({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 350,
                width: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/splash.jpg',
                      ),
                    ),
                    const Positioned(
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Find and Book Rides at\n Low Prices',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xffc2c2c2)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
