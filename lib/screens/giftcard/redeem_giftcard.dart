import 'package:cabmate_task/service/firebase_service.dart';
import 'package:cabmate_task/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RedeemGiftCardScreen extends StatelessWidget {
  final TextEditingController _giftCardCodeController = TextEditingController();

  RedeemGiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem Gift Card'),
        backgroundColor: Colors.blue, // Set the color for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gift card Code',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _giftCardCodeController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Gift Code',
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Enter received Gift Card Code in order to claim it. Gift Card amount will be credited into the wallet.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            GestureDetector(
              onTap: () {
                FirebaseService()
                    .redeemGiftCard(_giftCardCodeController.text,
                        FirebaseAuth.instance.currentUser!.uid)
                    .then((value) {
                  successBar(context, "Redeem Code Successfull");
                });
              },
              child: Container(
                height: 60,
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                    child: Text(
                  'Redeem',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
