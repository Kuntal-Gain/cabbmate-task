import 'package:cabmate_task/screens/giftcard/gift_card_successful_payment.dart';
import 'package:cabmate_task/utils/gift_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // You need to add the lottie package to your pubspec.yaml

class PaymentSuccessScreen extends StatefulWidget {
  final GiftCard giftCard;
  const PaymentSuccessScreen({super.key, required this.giftCard});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => GiftCardSuccessfulPayment(
                giftCard: widget.giftCard.giftCardNum,
              )));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/success_animation.json',
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            const Text(
              'Gift Card Purchased Successfully!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
