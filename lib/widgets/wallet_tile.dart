import 'package:flutter/material.dart';

Widget walletTile(IconData icon, String label, Color color) {
  return Column(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: const Color.fromARGB(255, 236, 236, 236),
        child: Icon(icon, color: color),
      ),
      Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}
