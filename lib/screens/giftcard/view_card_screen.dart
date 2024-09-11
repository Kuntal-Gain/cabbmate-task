import 'package:cabmate_task/utils/gift_card.dart';
import 'package:flutter/material.dart';

class ViewCardScreen extends StatefulWidget {
  const ViewCardScreen({super.key, required this.card});

  final GiftCard card;

  @override
  State<ViewCardScreen> createState() => _ViewCardScreenState();
}

class _ViewCardScreenState extends State<ViewCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Hi ${widget.card.reciverName},",
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RichText(
                  text: TextSpan(
                    style:
                        const TextStyle(color: Colors.black), // Default style
                    children: [
                      const TextSpan(
                          text: "You have received a Gift Card worth",
                          style: TextStyle(
                            fontSize: 23,
                          )),
                      TextSpan(
                        text: " \$${widget.card.amount} ",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      TextSpan(
                        text: " from ${widget.card.senderName}.",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'You can redeem it on Cabbmate App by entering your gift code.',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffc2c2c2)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.network(
                        widget.card.imageId,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            'Many many Happy returns of the Day',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Gift Card',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Gift Code',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.card.giftCardNum,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 150,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 2,
                              width: 20,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${widget.card.amount}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 35,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Use at Cabmate\nApp',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '*Conditions Apply',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please follow these steps to redeem the gift Card in the Cabbmate App.',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '1. Go to the profile section in Cabbmate app.',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '2. Tap on "Redeem Gift Card".',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '3. Enter the gift code (no spaces).',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Click below to download the app!.',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
