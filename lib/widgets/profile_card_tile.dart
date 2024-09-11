import 'package:flutter/material.dart';

Widget profileCardTile(Color color, String label, IconData icon) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: color,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
    title: Text(label),
    trailing: const Icon(Icons.arrow_forward_ios_rounded),
  );
}
