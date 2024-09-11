import 'package:cabmate_task/firebase_options.dart';
import 'package:cabmate_task/screens/credential/signup.dart';
import 'package:cabmate_task/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Debug: Show absolute path
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

// Method to check if the user is logged in
Future<User?> _checkUser() async {
  return FirebaseAuth.instance.currentUser;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<User?>(
        future: _checkUser(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.hasData && snap.data != null) {
            return const HomePage();
          } else {
            return const SignUpPage();
          }
        },
      ),
    );
  }
}
