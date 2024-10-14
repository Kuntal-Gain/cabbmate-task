import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  final String rideId;
  final String rideModel;
  final String rideNameplate;
  final String rideImg;
  final String color;
  final String driverImg;
  final String driverName;
  final String driverNumber;
  final String startLoc;
  final String endLoc;
  final Timestamp date;
  final double price;
  final String uid;

  Ride({
    required this.rideId,
    required this.rideModel,
    required this.rideNameplate,
    required this.rideImg,
    required this.color,
    required this.driverImg,
    required this.driverName,
    required this.driverNumber,
    required this.startLoc,
    required this.endLoc,
    required this.date,
    required this.price,
    required this.uid,
  });

  // Convert a Ride object to a Map (JSON format)
  Map<String, dynamic> toJson() {
    return {
      'rideId': rideId,
      'rideModel': rideModel,
      'rideNameplate': rideNameplate,
      'rideImg': rideImg,
      'color': color,
      'driverImg': driverImg,
      'driverName': driverName,
      'driverNumber': driverNumber,
      'startLoc': startLoc,
      'endLoc': endLoc,
      'date': date,
      'price': price,
      'uid': uid,
    };
  }

  // Create a Ride object from a Map (typically from Firestore)
  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      rideId: json['rideId'] ?? '',
      rideModel: json['rideModel'] ?? '',
      rideNameplate: json['rideNameplate'] ?? '',
      rideImg: json['rideImg'] ?? '',
      color: json['color'] ?? '',
      driverImg: json['driverImg'] ?? '',
      driverName: json['driverName'] ?? '',
      driverNumber: json['driverNumber'] ?? '',
      startLoc: json['startLoc'] ?? '',
      endLoc: json['endLoc'] ?? '',
      date: json['date'] ??
          Timestamp.now(), // Assuming date is stored as Timestamp
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      uid: json['uid'] ?? '',
    );
  }
}
