// ignore_for_file: empty_catches

import 'package:cabmate_task/models/requests.dart';
import 'package:cabmate_task/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/ride.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'rides';

  // Sign Up Method
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException {
      return null;
    }
  }

  // Sign In Method
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException {
      return null;
    }
  }

  // Sign Out Method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {}
  }

  // Create User in Firestore
  Future<void> createUser(String uid, UserModel userData) async {
    try {
      await _firestore.collection('users').doc(uid).set(userData.toJson());
    } catch (e) {}
  }

  // Update User in Firestore
  Future<void> updateUser(String uid, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('users').doc(uid).update(updatedData);
    } catch (e) {}
  }

  // Delete User from Firestore
  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {}
  }

  // Fetch User from Firestore
  Future<Map<String, dynamic>?> fetchUser(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Add a new Ride
  Future<void> addRide(Ride ride) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(ride.rideId)
          .set(ride.toJson());
      await _firestore.collection('users').doc(ride.uid).update({
        "publishedRides": ride.rideId,
      });
      print("Ride added successfully");
    } catch (e) {
      print("Error adding ride: $e");
    }
  }

  // Delete a Ride by ID
  Future<void> deleteRide(String rideId) async {
    try {
      await _firestore.collection(collectionPath).doc(rideId).delete();
      print("Ride deleted successfully");
    } catch (e) {
      print("Error deleting ride: $e");
    }
  }

  // Fetch a single Ride by ID
  Future<Ride?> getRideById(String rideId) async {
    try {
      DocumentSnapshot rideDoc =
          await _firestore.collection(collectionPath).doc(rideId).get();
      if (rideDoc.exists) {
        return Ride.fromJson(rideDoc.data() as Map<String, dynamic>);
      } else {
        print("Ride not found");
        return null;
      }
    } catch (e) {
      print("Error fetching ride: $e");
      return null;
    }
  }

  // Fetch all rides
  Future<List<Ride>> getAllRides() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(collectionPath).get();
      return snapshot.docs
          .map((doc) => Ride.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching rides: $e");
      return [];
    }
  }

  // Update a ride (by providing updated Ride object)
  Future<void> updateRide(Ride ride) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(ride.rideId)
          .update(ride.toJson());
      print("Ride updated successfully");
    } catch (e) {
      print("Error updating ride: $e");
    }
  }

  // Book a ride (add rideId to user's bookedRides field)
  Future<void> bookRide(Ride ride, Requests request) async {
    final _currUser = FirebaseAuth.instance.currentUser!.uid;
    try {
      DocumentReference rideDoc =
          _firestore.collection('rides').doc(request.requestId);
      DocumentReference requestDoc = _firestore
          .collection('requests')
          .doc(request.requestId); // Auto-generate ID for the reques

      await requestDoc.set({
        'passengerImg': request.imageId,
        'passengerName': request.passengerName,
        'paymentMethod': request.method,
        'totalPassengers': request.total,
        'status': request.status, // Default status before approval/rejection
        'rideId': request.rideId,
        'userId': request.uid,
        'timestamp': request.datetime, // You can add a timestamp for tracking
        'fare': request.fare,
        'rid': request.requestId,
      });

      await rideDoc.update({
        'total': ride.noOfPassenger - request.total,
      });

      print("Ride request created successfully");
    } catch (e) {
      print("Error creating ride request: $e");
    }
  }

  Future<void> acceptRide(String requestId) async {
    try {
      DocumentReference requestDoc =
          _firestore.collection('requests').doc(requestId);

      await requestDoc.update({
        'status': 'accepted',
      });

      print("Ride request accepted successfully");
    } catch (e) {
      print("Error accepting ride request: $e");
    }
  }

  Future<void> rejectRide(String requestId) async {
    try {
      DocumentReference requestDoc =
          _firestore.collection('requests').doc(requestId);

      await requestDoc.update({
        'status': 'rejected',
      });

      print("Ride request rejected successfully");
    } catch (e) {
      print("Error rejecting ride request: $e");
    }
  }

  Future<List<Requests>> fetchRequests(String rideId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('requests')
          .where('rideId', isEqualTo: rideId)
          .get();

      // Map the documents to the Requests model
      List<Requests> requests = snapshot.docs.map((doc) {
        return Requests(
          requestId: doc['rid'],
          imageId: doc['passengerImg'],
          passengerName: doc['passengerName'],
          method: doc['paymentMethod'],
          total: doc['totalPassengers'],
          status: doc['status'],
          rideId: doc['rideId'],
          uid: doc['userId'],
          datetime: doc['timestamp'],
          fare: doc['fare'],
        );
      }).toList();

      return requests;
    } catch (e) {
      print("Error fetching requests: $e");
      return [];
    }
  }

  Future<List<Ride>> fetchBookedRides(List<String> rideIds) async {
    try {
      // Query for multiple documents using the list of rideIds
      QuerySnapshot querySnapshot = await _firestore
          .collection(collectionPath)
          .where(FieldPath.documentId, whereIn: rideIds)
          .get();

      // Map the results to a list of Ride objects
      return querySnapshot.docs
          .map((doc) => Ride.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching booked rides: $e");
      return [];
    }
  }
}
