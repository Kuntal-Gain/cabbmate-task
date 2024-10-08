import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:crypto/crypto.dart';

class ApiService {
  // SMS provider (Twilio)
  final String accountSid = dotenv.env['TWILIO_ACCOUNT_SID']!;
  final String authToken = dotenv.env['TWILIO_AUTH_TOKEN']!;
  final String messagingServiceSid = dotenv.env['TWILIO_MESSAGE_SERVICE_SID']!;

  // Payment provider (PayU)
  final String payuMerchantKey = dotenv.env['PAYU_MERCHANT_KEY']!;
  final String payuSalt = dotenv.env['PAYU_SALT']!;
  final String payuBaseUrl = dotenv.env['PAYU_BASE_URL']!;

  // Send SMS method using Twilio
  Future<void> sendSms(String recipientNumber, String message) async {
    if (recipientNumber.isEmpty || message.isEmpty) {
      if (kDebugMode) {
        print('Recipient number and message are required.');
      }
      return;
    }

    final url =
        'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
      },
      body: {
        'To': recipientNumber,
        'MessagingServiceSid': messagingServiceSid,
        'Body': message,
      },
    );

    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 201) {
    } else {}
  }

  // Generate PayU hash using SHA-512
  String generatePayUHash(String key, String command, String var1) {
    final input = '$key|$command|$var1|$payuSalt';
    final bytes = utf8.encode(input);
    final digest = sha512.convert(bytes);
    return digest.toString();
  }

  // Verify Payment method using PayU's POST service
  Future<void> verifyPayUPayment(String transactionId) async {
    const command = 'verify_payment';
    final hash = generatePayUHash(payuMerchantKey, command, transactionId);

    final url = Uri.parse('$payuBaseUrl/merchant/postservice?form=2');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: {
        'key': payuMerchantKey,
        'command': command,
        'var1': transactionId,
        'hash': hash,
      },
    );

    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {}
  }

  // Example of another PayU command: refund transaction
  Future<void> refundPayUTransaction(String transactionId) async {
    const command = 'refund_transaction';
    final hash = generatePayUHash(payuMerchantKey, command, transactionId);

    final url = Uri.parse('$payuBaseUrl/merchant/postservice?form=2');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: {
        'key': payuMerchantKey,
        'command': command,
        'var1': transactionId, // Pass the transaction ID for refund
        'hash': hash,
      },
    );

    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {}
  }

  // Pay Now method
  Future<bool> payNow() async {
    // Payment details
    const String transactionId = 'txnid132735124320';
    const String amount = '10.00';
    const String firstName = 'Ashish';
    const String email = 'test@gmail.com';
    const String phone = '9876543210';
    const String productInfo = 'iPhone';
    const String pg = 'TESTPG';
    const String bankCode = 'TESTPGNB';
    const String surl =
        'https://test-payment-middleware.payu.in/simulatorResponse';
    const String furl =
        'https://test-payment-middleware.payu.in/simulatorResponse';

    // Use the command 'payment' for the payment process
    const String command = 'payment';

    // Generate the hash using the provided method
    final String hash = generatePayUHash(
      payuMerchantKey,
      command,
      transactionId, // Using transaction ID as var1
    );

    // Making the payment request
    final response = await http.post(
      Uri.parse('https://test.payu.in/_payment'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'key': payuMerchantKey,
        'txnid': transactionId,
        'amount': amount,
        'firstname': firstName,
        'email': email,
        'phone': phone,
        'productinfo': productInfo,
        'pg': pg,
        'bankcode': bankCode,
        'surl': surl,
        'furl': furl,
        'hash': hash,
      },
    );

    // Handle the response
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
