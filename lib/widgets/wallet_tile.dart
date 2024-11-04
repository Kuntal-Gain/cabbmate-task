import 'package:flutter/material.dart';

Widget walletTile(IconData icon, String label, Color color) {
  return SizedBox(
    width: 100, // Add size constraints
    child: Column(
      mainAxisSize: MainAxisSize.min, // Prevent over-expansion
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color.fromARGB(255, 236, 236, 236),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8), // Add spacing
        Text(
          label,
          style: const TextStyle(
            fontSize: 16, // Adjust the size for better fit
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, // Center the text
        ),
      ],
    ),
  );
}
