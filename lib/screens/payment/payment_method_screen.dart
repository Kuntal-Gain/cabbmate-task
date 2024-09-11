// ignore_for_file: use_build_context_synchronously

import 'package:cabmate_task/screens/payment/payment_success.dart';
import 'package:cabmate_task/service/api_service.dart';
import 'package:cabmate_task/utils/gift_card.dart';
import 'package:cabmate_task/utils/payment.dart';
import 'package:cabmate_task/widgets/payment_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key, required this.card});

  final GiftCard card;

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  List<Payment> methods = [
    Payment(icon: Icons.credit_card, label: "Card", value: "123 456 789"),
    Payment(icon: Icons.wallet, label: "Wallet", value: "\$115.00"),
  ];

  int selectedIdx = 0;

  String generateEmail() {
    return """
    <html>

<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        .container {
            border: 1px solid #c2c2c2;
            padding: 16px;
            background-color: white;
            max-width: 600px;
            /* Limit the maximum width */
            margin: auto;
            /* Center the container */
            border-radius: 8px;
            /* Rounded corners */
        }

        .header {
            font-size: 20px;
            margin-bottom: 12px;
        }

        .gift-code {
            font-weight: bold;
            font-size: 20px;
        }

        .gift-amount {
            font-weight: bold;
            color: red;
            font-size: 28px;
            /* Slightly smaller */
        }

        .instructions {
            font-size: 16px;
        }

        img {
            width: 100%;
            /* Responsive image */
            height: auto;
            border-radius: 8px;
            /* Rounded corners for image */
        }

        @media (max-width: 600px) {
            .container {
                padding: 12px;
            }

            .header {
                font-size: 18px;
            }

            .gift-code {
                font-size: 18px;
            }

            .gift-amount {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>
    <div style="text-align: center;">
        <h2 class="header">Hi ${widget.card.reciverName},</h2>
        <p>
            You have received a Gift Card worth
            <strong style="color: red;">\$${widget.card.amount}</strong>
            from Emma Brown.
        </p>
        <p>
            You can redeem it on Cabbmate App by entering your gift code.
        </p>
    </div>
    <div class="container">
        <img src=${widget.card.imageId}
            alt="Gift Card" />
        <h3 style="color: blue; text-align: center;">Many many Happy returns of the Day</h3>
        <h4 style="text-align: center;">Gift Card</h4>
        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
            <div>
                <strong>Gift Code</strong><br>
                <span class="gift-code">${widget.card.giftCardNum}</span>
            </div>
            <div style="border-left: 2px solid grey; padding-left: 20px; margin-left: 20px;">
                <span class="gift-amount">\$${widget.card.amount}</span><br>
                <span>Use at Cabmate App</span><br><br>
                <span style="color: blue;">*Conditions Apply</span>
            </div>
        </div>
        <h4 class="instructions">Please follow these steps to redeem the gift Card in the Cabbmate App:</h4>
        <ol class="instructions">
            <li>Go to the profile section in Cabbmate app.</li>
            <li>Tap on "Redeem Gift Card".</li>
            <li>Enter the gift code (no spaces).</li>
        </ol>
        <p>Click below to download the app!</p>
    </div>
</body>

</html>
    
    """;
  }

  // Method to send email
  Future<void> sendEmailWithGmailSMTP() async {
    // Replace with your email and password (or App Password if you have 2FA enabled)
    String username = dotenv.env['EMAIL_ID']!;
    String password = dotenv.env['PASSWRD']!;

    // Set up the SMTP server
    final smtpServer = gmail(username, password);

    // Compose the email
    final message = Message()
      ..from = Address(username, 'Cabbmate')
      ..recipients
          .add(widget.card.reciverEmail) // Replace with recipient's email
      ..subject = 'Gift Card Received' // Subject of the email
      ..html = generateEmail(); // HTML content of the email

    try {
      // Send the email
      final sendReport = await send(message, smtpServer);
      if (kDebugMode) {
        print('Message sent: $sendReport');
      }
    } on MailerException catch (e) {
      if (kDebugMode) {
        print('Message not sent. ${e.message}');
      }
      for (var p in e.problems) {
        if (kDebugMode) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Select Payment Method',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xfff6f6f6),
              border: Border.all(
                color: const Color(0xffc2c2c2),
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListView.builder(
              itemCount: methods.length,
              itemBuilder: (ctx, idx) {
                final pm = methods[idx];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIdx = idx;
                    });
                  },
                  child: paymentCard(
                      pm.icon, pm.label, selectedIdx == idx, pm.value),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () async {
              final message =
                  'Hi , ${widget.card.reciverName}. You have received a Gift Card worth \$${widget.card.amount} from ${widget.card.senderName}. You can redeem it on cabbmate by entering your Gift code: ${widget.card.giftCardNum}';
              final number = "91${widget.card.reciverPhone}";

              await ApiService().sendSms(number, message).then((val) {
                // send mail
                sendEmailWithGmailSMTP();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => PaymentSuccessScreen(
                      giftCard: widget.card,
                    ),
                  ),
                );
              });
            },
            child: Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
