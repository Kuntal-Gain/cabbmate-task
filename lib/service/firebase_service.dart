// ignore_for_file: empty_catches

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
}
