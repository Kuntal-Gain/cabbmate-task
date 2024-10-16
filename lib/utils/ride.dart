import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  final String rideId;
  final String rideModel;
  final String rideNameplate;
  final String rideImg;
  final String brand;
  final String color;
  final String driverImg;
  final String driverName;
  final String driverNumber;
  final String startLoc;
  final String endLoc;
  final Timestamp startTime;
  final Timestamp endTime;
  final double price;
  final String uid;
  final int noOfPassenger;

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
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.uid,
    required this.noOfPassenger,
    required this.brand,
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
      'startTime': startTime,
      'endTime': endTime,
      'price': price,
      'uid': uid,
      'total': noOfPassenger,
      'brand': brand,
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
      startTime: json['startTime'] ?? Timestamp.now(),
      endTime: json['endTime'] ?? Timestamp.now(),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      uid: json['uid'] ?? '',
      noOfPassenger: json['total'] ?? '',
      brand: json['brand'] ?? '',
    );
  }
}
