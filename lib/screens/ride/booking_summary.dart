// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:cabmate_task/models/requests.dart';
import 'package:cabmate_task/screens/homepage.dart';
import 'package:cabmate_task/screens/payment/payment_method_screen.dart';
import 'package:cabmate_task/service/firebase_service.dart';
import 'package:cabmate_task/utils/ride.dart';
import 'package:cabmate_task/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_format/flutter_datetime_format.dart' as fd;

class BookingSummary extends StatefulWidget {
  const BookingSummary({super.key, required this.ride, required this.seats});
  final Ride ride;
  final int seats;
  @override
  // ignore: library_private_types_in_public_api
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  // State variables for price and booking fee

  final double bookingFee = 0.20;
  String username = "";

  // Getter to calculate the total price
  double get totalPrice =>
      widget.ride.price * widget.seats + bookingFee * widget.seats;

  var customer = 1;

  String generateRequestId() {
    final random = Random();
    final randomNumber =
        random.nextInt(1000000); // Generates a number between 0 and 999999
    final requestId =
        'RID${randomNumber.toString().padLeft(6, '0')}'; // Ensure it's 6 digits long
    return requestId;
  }

  Future<String?> getUsername(String uid) async {
    try {
      // Fetch the user's document from Firestore
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Check if the document exists
      if (userDoc.exists) {
        // Assuming the username is stored in a field called 'username'
        return userDoc['name'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void getName() async {
    final user = await getUsername(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      username = user!;
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery to adapt the UI for different screen sizes
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    void showBookingDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade200,
                  radius: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/1828/1828640.png'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Booking Requested",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your booking request has been sent successfully. You will be notified once the driver will approve it.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 60,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const HomePage(selectedIdx: 2),
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Text(
                              'View Rides',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Booking Summary',
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Ride Date
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Text(
                    'Ride Date:',
                    style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '${fd.FLDateTime.formatWithNames(widget.ride.startTime.toDate(), 'EEE, MMMM DD, YYYY')}  at ${widget.ride.startTime.toDate().hour}:${widget.ride.startTime.toDate().minute.toString().padLeft(2, '0')} ${widget.ride.startTime.toDate().hour < 12 ? 'AM' : 'PM'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Price Breakdown
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Container(
              width: 500,
              height: 180,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueGrey.shade200),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: Column(
                      children: [
                        // Seat price row
                        priceRow(
                            '${widget.seats} Seat X \$${widget.ride.price.toStringAsFixed(2)}',
                            widget.ride.price * widget.seats,
                            screenWidth),
                        SizedBox(height: screenHeight * 0.01),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        // Booking fees row
                        priceRow('Booking fees', bookingFee * widget.seats,
                            screenWidth),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          // Total Price
          const Spacer(),

          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // To make sure it doesn't take more space than needed
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "For ${widget.seats} passengers",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      // ignore: unnecessary_brace_in_string_interps
                      "\$${totalPrice}",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (_) => const PaymentMethodScreen(
                          paymentType: PaymentType.Payment,
                          paymentData: "Car data",
                        ),
                      ),
                    )
                        .then((selectedPaymentMethod) {
                      if (selectedPaymentMethod != null) {
                        // Debug print

                        showBookingDialog(
                            context); // Show booking dialog after payment
                        FirebaseService().bookRide(
                          widget.ride,
                          Requests(
                            requestId: generateRequestId(),
                            imageId: "",
                            passengerName: username,
                            method:
                                selectedPaymentMethod, // Use selected payment method
                            total: widget.seats,
                            status: "pending",
                            rideId: widget.ride.rideId,
                            uid: widget.ride.uid,
                            datetime: Timestamp.now(),
                            fare: widget.ride.price,
                          ),
                        );

                        successBar(context, "Ride Booked Successfully");
                      } else {}
                    });
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build price rows
  Widget priceRow(String label, double price, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
