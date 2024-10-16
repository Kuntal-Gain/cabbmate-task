import 'package:cloud_firestore/cloud_firestore.dart';

class Requests {
  final String requestId;
  final String imageId;
  final String passengerName;
  final String method;
  final int total;
  final String status;
  final String rideId;
  final String uid;
  final Timestamp datetime;
  final double fare;

  Requests({
    required this.imageId,
    required this.passengerName,
    required this.method,
    required this.total,
    required this.status,
    required this.rideId,
    required this.uid,
    required this.datetime,
    required this.fare,
    required this.requestId,
  });
}
