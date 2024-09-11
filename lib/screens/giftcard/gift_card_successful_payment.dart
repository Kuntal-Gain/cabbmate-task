import 'package:cabmate_task/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GiftCardSuccessfulPayment extends StatefulWidget {
  final String giftCard;
  const GiftCardSuccessfulPayment({super.key, required this.giftCard});

  @override
  State<GiftCardSuccessfulPayment> createState() =>
      _GiftCardSuccessfulPaymentState();
}

class _GiftCardSuccessfulPaymentState extends State<GiftCardSuccessfulPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/images/accept.png',
                height: 60,
                width: 60,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Payment Successfull',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Your Gift Card has been sent , Please note Gift Card code ${widget.giftCard}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const HomePage()),
                  (route) => false,
                );
              },
              child: Container(
                height: 60,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Center(
                  child: Text('Close',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
