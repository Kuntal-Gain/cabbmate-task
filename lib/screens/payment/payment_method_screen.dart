// ignore_for_file: use_build_context_synchronously, constant_identifier_names

import 'package:cabmate_task/screens/payment/payment_success.dart';
import 'package:cabmate_task/service/api_service.dart';
import 'package:cabmate_task/utils/gift_card.dart';
import 'package:cabmate_task/utils/payment.dart';
import 'package:cabmate_task/widgets/payment_card.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

enum PaymentType { GiftCard, Wallet, Payment }

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({
    super.key,
    required this.paymentType,
    required this.paymentData,
  });

  final PaymentType paymentType;
  final dynamic paymentData;

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  List<Payment> methods = [
    Payment(icon: Icons.credit_card, label: "Card", value: "123 456 789"),
    Payment(icon: Icons.wallet, label: "Wallet", value: "\$115.00"),
  ];

  int selectedIdx = 0;

  String generateEmail(GiftCard card) {
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
        <h2 class="header">Hi ${card.reciverName},</h2>
        <p>
            You have received a Gift Card worth
            <strong style="color: red;">\$${card.amount}</strong>
            from Emma Brown.
        </p>
        <p>
            You can redeem it on Cabbmate App by entering your gift code.
        </p>
    </div>
    <div class="container">
        <img src=${card.imageId}
            alt="Gift Card" />
        <h3 style="color: blue; text-align: center;">Many many Happy returns of the Day</h3>
        <h4 style="text-align: center;">Gift Card</h4>
        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
            <div>
                <strong>Gift Code</strong><br>
                <span class="gift-code">${card.giftCardNum}</span>
            </div>
            <div style="border-left: 2px solid grey; padding-left: 20px; margin-left: 20px;">
                <span class="gift-amount">\$${card.amount}</span><br>
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
  Future<void> sendEmailWithGmailSMTP(GiftCard card) async {
    // Replace with your email and password (or App Password if you have 2FA enabled)
    String username = dotenv.env['EMAIL_ID']!;
    String password = dotenv.env['PASSWRD']!;

    // Set up the SMTP server
    final smtpServer = gmail(username, password);

    // Compose the email
    final message = Message()
      ..from = Address(username, 'Cabbmate')
      ..recipients.add(card.reciverEmail) // Replace with recipient's email
      ..subject = 'Gift Card Received' // Subject of the email
      ..html = generateEmail(widget.paymentData); // HTML content of the email

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

  // Corrected Bottom Sheet method
  void showCardDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: CardDetailsForm(
            data: widget.paymentData,
            type: widget.paymentType,
          ),
        );
      },
    );
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
              if (widget.paymentType == PaymentType.GiftCard) {
                final message =
                    'Hi , ${widget.paymentData.reciverName}. You have received a Gift Card worth \$${widget.paymentData.amount} from ${widget.paymentData.senderName}. You can redeem it on cabbmate by entering your Gift code: ${widget.paymentData.giftCardNum}';
                final number = "91${widget.paymentData.reciverPhone}";

                await ApiService().sendSms(number, message).then((val) {
                  // send mail
                  sendEmailWithGmailSMTP(widget.paymentData);
                });
              } else if (widget.paymentType == PaymentType.Payment) {}

              // payment logic
              showCardDetailsBottomSheet(context);

              // await ApiService().payNow();
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

class CardDetailsForm extends StatelessWidget {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  CardDetailsForm({super.key, required this.data, required this.type});

  final PaymentType type;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Enter Card Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 75,
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffc2c2c2)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: TextField(
              controller: cardNumberController,
              decoration: const InputDecoration(
                labelText: 'Card Number',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 75,
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffc2c2c2)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: TextField(
                    controller: expiryDateController,
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 75,
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffc2c2c2)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: TextField(
                    controller: cvvController,
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () async {
            // Initiate the payment

            var isSuccessful = await ApiService().payNow();
            if (isSuccessful) {
              if (type == PaymentType.GiftCard) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => PaymentSuccessScreen(giftCard: data)));
              } else if (type == PaymentType.Payment) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            } else {
              DelightToastBar(
                builder: (context) => const ToastCard(
                  leading: Icon(
                    Icons.cancel,
                    size: 28,
                  ),
                  title: Text(
                    "Payment Failed! Try Again",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ).show(context);
            }
          },
          child: Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Pay',
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
    );
  }
}
