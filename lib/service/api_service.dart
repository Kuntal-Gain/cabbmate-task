import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String accountSid = dotenv.env['TWILIO_ACCOUNT_SID']!;
  final String authToken = dotenv.env['TWILIO_AUTH_TOKEN']!;
  final String messagingServiceSid = dotenv.env['TWILIO_MESSAGE_SERVICE_SID']!;

  Future<void> sendSms(String recipientNumber, String message) async {
    // Check for null or empty input
    if (recipientNumber.isEmpty) {
      if (kDebugMode) {
        print('Recipient number is required');
      }
      return;
    }
    if (message.isEmpty) {
      if (kDebugMode) {
        print('Message is required');
      }
      return;
    }

    // Construct the URL
    final url =
        'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';

    // Prepare the request
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

    // Log the response
    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response Body: ${response.body}');
    }

    // Check for success
    if (response.statusCode == 201) {
      if (kDebugMode) {
        print('Message sent successfully');
      }
    } else {
      if (kDebugMode) {
        print(
            'Failed to send message: ${response.statusCode} - ${response.body}');
      }
    }
  }
}
