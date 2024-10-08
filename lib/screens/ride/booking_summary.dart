import 'package:cabmate_task/screens/payment/payment_method_screen.dart';
import 'package:flutter/material.dart';

class BookingSummary extends StatefulWidget {
  const BookingSummary({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  // State variables for price and booking fee
  final double seatPrice = 4.00;
  final double bookingFee = 0.20;

  // Getter to calculate the total price
  double get totalPrice => seatPrice + bookingFee;

  var customer = 1;

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
                    Expanded(
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
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Tue, 19th Sep 23 at 11:00 AM'),
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
                        priceRow('1 Seat X \$${seatPrice.toStringAsFixed(2)}',
                            seatPrice, screenWidth),
                        SizedBox(height: screenHeight * 0.01),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        // Booking fees row
                        priceRow('Booking fees', bookingFee, screenWidth),
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
                          "For $customer passengers",
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
                        .then((state) {
                      // logic to show dialog box
                      // ignore: use_build_context_synchronously
                      showBookingDialog(context);
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
                ),
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
