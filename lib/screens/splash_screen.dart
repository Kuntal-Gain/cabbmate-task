import 'package:cabmate_task/screens/credential/signup.dart';
import 'package:cabmate_task/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Start the fade-in animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  // Method to check if the user is logged in
  Future<User?> _checkUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<User?>(
        future: _checkUser(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            // Show the splash screen while waiting for the result
            return Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 2),
                curve: Curves.easeOut,
                child: Image.asset('assets/images/logo.jpg'),
              ),
            );
          } else if (snap.hasData && snap.data != null) {
            // If user is logged in, navigate to HomePage
            return const HomePage();
          } else {
            // If no user, navigate to SignUpPage
            return const SignUpPage();
          }
        },
      ),
    );
  }
}
