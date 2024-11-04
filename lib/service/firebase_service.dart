// ignore_for_file: empty_catches

import 'package:cabmate_task/models/requests.dart';
import 'package:cabmate_task/models/transaction.dart';
import 'package:cabmate_task/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/gift_card.dart';
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
    } catch (e) {}
  }

  // Delete a Ride by ID
  Future<void> deleteRide(String rideId) async {
    try {
      await _firestore.collection(collectionPath).doc(rideId).delete();
    } catch (e) {}
  }

  // Fetch a single Ride by ID
  Future<Ride?> getRideById(String rideId) async {
    try {
      DocumentSnapshot rideDoc =
          await _firestore.collection(collectionPath).doc(rideId).get();
      if (rideDoc.exists) {
        return Ride.fromJson(rideDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
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
    } catch (e) {}
  }

  Future<void> bookRide(Ride ride, Requests request) async {
    try {
      // References to documents
      DocumentReference rideDoc =
          _firestore.collection('rides').doc(ride.rideId);
      DocumentReference requestDoc =
          _firestore.collection('requests').doc(request.requestId);
      final userDoc = _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      // Add the request document
      await requestDoc.set({
        'passengerImg': request.imageId,
        'passengerName': request.passengerName,
        'paymentMethod': request.method,
        'totalPassengers': request.total,
        'status': request.status,
        'rideId': request.rideId,
        'userId': request.uid,
        'timestamp': request.datetime,
        'fare': request.fare,
        'rid': request.requestId,
      });

      // Update the ride document
      await rideDoc.update({
        'total': ride.noOfPassenger - request.total,
      });

      await userDoc.update({
        "bookedRides": FieldValue.arrayUnion([ride.rideId]),
      });
    } catch (e) {
      print('Error booking ride: $e');
    }
  }

  // Future<void> bookRide(Ride ride, Requests request) async {
  //   try {
  //     DocumentReference userDoc =
  //         _firestore.collection('users').doc(request.uid);

  //     // Adding more detailed logging here
  //     print("Attempting to add request to user's bookedRides field...");

  //     // Add request to 'bookedRides'
  //     await userDoc.update({
  //       "bookedRides": FieldValue.arrayUnion([request.requestId]),
  //     });

  //     print("Successfully added request to bookedRides.");

  //     // Force data to be fetched from the server
  //     final userSnapshot = await userDoc.get(GetOptions(source: Source.server));

  //     // Check if the document exists
  //     if (userSnapshot.exists) {
  //       final data = userSnapshot.data() as Map<String, dynamic>; // Cast to Map
  //       if (data.containsKey('bookedRides')) {
  //         print("User document after update: ${data['bookedRides']}");
  //       } else {
  //         print("No 'bookedRides' field found in the user document.");
  //       }
  //     } else {
  //       print("User document not found.");
  //     }
  //   } catch (e) {
  //     print('Error updating bookedRides field: $e');
  //   }
  // }

  Future<void> acceptRide(String requestId) async {
    try {
      DocumentReference requestDoc =
          _firestore.collection('requests').doc(requestId);

      await requestDoc.update({
        'status': 'accepted',
      });
    } catch (e) {}
  }

  Future<void> rejectRide(String requestId) async {
    try {
      DocumentReference requestDoc =
          _firestore.collection('requests').doc(requestId);

      await requestDoc.update({
        'status': 'rejected',
      });
    } catch (e) {}
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
      return [];
    }
  }

  // Method to add a new gift card
  Future<void> addGiftCard(GiftCard giftCard) async {
    try {
      await _firestore
          .collection('giftcards')
          .doc(giftCard.giftCardNum)
          .set(giftCard.toMap());
    } catch (e) {
      // Handle the error appropriately in your app
    }
  }

  Future<void> redeemGiftCard(String giftCardNum, String uid) async {
    try {
      DocumentReference giftCardRef =
          _firestore.collection('giftcards').doc(giftCardNum);
      DocumentSnapshot giftCardSnapshot = await giftCardRef.get();

      if (giftCardSnapshot.exists) {
        // Retrieve the gift card details
        final giftCardData = giftCardSnapshot.data() as Map<String, dynamic>;
        double amount = giftCardData['amount'];
        String reciverPhone = giftCardData['reciverPhone'];

        // Get the receiver's user document reference
        DocumentReference receiverRef = _firestore
            .collection('users')
            .doc(uid); // Adjust based on your user identification logic
        DocumentSnapshot receiverSnapshot = await receiverRef.get();

        if (receiverSnapshot.exists) {
          // Cast receiverSnapshot.data() to Map<String, dynamic>
          final receiverData = receiverSnapshot.data() as Map<String, dynamic>;

          // Update the receiver's balance or any relevant field
          double currentBalance = receiverData['wallet'] ??
              0; // Now we can safely access the 'balance' field
          await receiverRef.update({'wallet': currentBalance + amount});

          // Optionally, you can mark the gift card as redeemed
          await giftCardRef.update({
            'redeemed': true
          }); // Add 'redeemed' field or any other necessary logic
        } else {}
      } else {}
    } catch (e) {
      // Handle the error appropriately in your app
    }
  }

  // Method to send money from one user to another
  Future<void> sendMoney(
      String senderId, String receiverId, double amount) async {
    DocumentReference senderDoc = _firestore.collection('users').doc(senderId);
    DocumentReference receiverDoc =
        _firestore.collection('users').doc(receiverId);

    // Get sender and receiver wallets
    DocumentSnapshot senderSnapshot = await senderDoc.get();
    DocumentSnapshot receiverSnapshot = await receiverDoc.get();

    double senderWallet = senderSnapshot['wallet'];
    double receiverWallet = receiverSnapshot['wallet'];

    // Check if the sender has enough money
    if (senderWallet >= amount) {
      // Deduct from sender and add to receiver
      await senderDoc.update({'wallet': senderWallet - amount});
      await receiverDoc.update({'wallet': receiverWallet + amount});
    } else {
      throw Exception('Insufficient balance');
    }
  }

  Future<void> addMoney(String userId, TransactionModel txn) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);
    DocumentSnapshot userSnapshot = await userDoc.get();

    // Cast wallet to double to prevent type issues
    double currentWallet = (userSnapshot['wallet'] as num).toDouble();

    // Update wallet with the added amount from txn.ammt
    await userDoc.update({'wallet': currentWallet + txn.ammt});

    // Store the transaction in the user's 'transactions' sub-collection
    await userDoc.collection('transactions').doc(txn.txnId).set({
      'txnId': txn.txnId,
      'ammt': txn.ammt,
      'dateOfTransaction': txn.dateOfTransaction,
      'sender': txn.sender,
      'isCredit': txn.isCredit,
    });
  }

  // Method to pay money from user to a merchant
  Future<void> payMoney(String userId, String merchantId, double amount) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);
    DocumentReference merchantDoc =
        _firestore.collection('merchants').doc(merchantId);

    // Get user and merchant wallets
    DocumentSnapshot userSnapshot = await userDoc.get();
    DocumentSnapshot merchantSnapshot = await merchantDoc.get();

    double userWallet = userSnapshot['wallet'];
    double merchantWallet = merchantSnapshot['wallet'];

    // Check if the user has enough money
    if (userWallet >= amount) {
      // Deduct from user and add to merchant
      await userDoc.update({'wallet': userWallet - amount});
      await merchantDoc.update({'wallet': merchantWallet + amount});
    } else {
      throw Exception('Insufficient balance');
    }
  }

  Future<List<TransactionModel>> fetchTransactionsByUid(String userId) async {
    // Reference to the user's transactions sub-collection
    CollectionReference transactionsRef =
        _firestore.collection('users').doc(userId).collection('transactions');

    // Fetch the transactions
    QuerySnapshot transactionSnapshot = await transactionsRef.get();

    // Map the fetched documents to a list of TransactionModel using the factory constructor
    List<TransactionModel> transactions = transactionSnapshot.docs.map((doc) {
      return TransactionModel.fromDocument(doc);
    }).toList();

    return transactions;
  }
}
