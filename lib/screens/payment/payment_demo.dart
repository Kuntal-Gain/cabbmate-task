import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../service/api_service.dart';

class PaymentDemo extends StatefulWidget {
  const PaymentDemo({Key? key}) : super(key: key);

  @override
  State<PaymentDemo> createState() => _PaymentDemoState();
}

class _PaymentDemoState extends State<PaymentDemo> {
  final ApiService _apiService = ApiService();

  // Example Transaction ID (Replace with actual transaction ID for testing)
  final String testTransactionId = '1234567890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayU Payment Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Button to test the verify payment method
            ElevatedButton(
              onPressed: () async {
                await _apiService.verifyPayUPayment(testTransactionId);
              },
              child: const Text('Verify Payment'),
            ),
            const SizedBox(height: 10),

            // Button to test refund transaction
            ElevatedButton(
              onPressed: () async {
                await _apiService.refundPayUTransaction(testTransactionId);
              },
              child: const Text('Refund Transaction'),
            ),
            const SizedBox(height: 10),

            // Button to test sending SMS (Twilio)
            ElevatedButton(
              onPressed: () async {
                String recipientNumber =
                    '+911234567890'; // Replace with test number
                String message = 'Test message from PayU demo';
                await _apiService.sendSms(recipientNumber, message);
              },
              child: const Text('Send SMS (Twilio)'),
            ),
            const SizedBox(height: 10),

            // Button to simulate a new PayU method (if needed)
            ElevatedButton(
              onPressed: () {
                // Add other method calls if you need to test more APIs
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Additional method placeholder')),
                );
              },
              child: const Text('Placeholder for New Method'),
            ),
          ],
        ),
      ),
    );
  }
}
