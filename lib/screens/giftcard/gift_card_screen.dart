import 'dart:math';

import 'package:cabmate_task/screens/giftcard/view_card_screen.dart';
import 'package:cabmate_task/screens/payment/payment_method_screen.dart';
import 'package:cabmate_task/utils/gift_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/country.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  List<String> cards = [
    'https://img.freepik.com/free-vector/people-holding-birthday-party-icons_53876-43075.jpg',
    'https://img.freepik.com/free-vector/happy-young-people-bringing-gifts-tree_52683-28217.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1724371200&semt=ais_hybrid',
    'https://img.pikbest.com/png-images/20211009/happy-people-dancing-at-party-flat-vector-illustration_6138979.png!bw700',
  ];

  // controllers
  final moneyController = TextEditingController();
  final messageController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  int selectedIdx = 0;
  double ammount = 0;
  String selectedCode = codes[0].code;
  String code = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String generateGiftcard() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();

    return List.generate(10, (index) {
      return characters[random.nextInt(characters.length)];
    }).join('');
  }

  @override
  void initState() {
    code = generateGiftcard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Send Gift Card',
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/324/324687.png',
                    height: 40,
                    width: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200, // Fixed height for the card list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cards.length,
                  itemBuilder: (ctx, idx) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIdx = idx;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          border: selectedIdx == idx
                              ? Border.all(color: Colors.blue, width: 5)
                              : Border.all(
                                  color: Colors.transparent,
                                ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.network(cards[idx]),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xfff6f6f6),
                  border: Border.all(
                    color: const Color(0xffc2c2c2),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gift Card Amount',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xffc2c2c2),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: TextFormField(
                                controller: moneyController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field cannot be empty';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    ammount =
                                        double.parse(moneyController.text);
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'USD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Max amount : \$ 10,000.00',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Text(
                      'Personal Message',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xffc2c2c2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextFormField(
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          controller: messageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xfff6f6f6),
                  border: Border.all(
                    color: const Color(0xffc2c2c2),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Receiver's Name",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xffc2c2c2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'Robert Smith',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Receiver's Email",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xffc2c2c2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'robert_smith@demo.com',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Receiver's Phone",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xffc2c2c2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  DropdownButton<String>(
                                    value:
                                        selectedCode, // Currently selected code
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCode = newValue!;
                                      });
                                    },
                                    items: codes.map<DropdownMenuItem<String>>(
                                        (CountryCode country) {
                                      return DropdownMenuItem<String>(
                                        value: country
                                            .code, // Set the value to the country code
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Image.network(country
                                                  .flag), // Show the country flag
                                            ),
                                            const SizedBox(width: 5),
                                            Text(country
                                                .code), // Show the country code
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "|",
                                    style: TextStyle(
                                        fontSize: 35, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field cannot be empty';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: '2586543570',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print(code);
                    }

                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ViewCardScreen(
                          card: GiftCard(
                            imageId: cards[selectedIdx],
                            amount: ammount,
                            message: messageController.text,
                            reciverName: nameController.text,
                            reciverPhone: phoneController.text,
                            reciverEmail: emailController.text,
                            senderName: 'Emma Brown',
                            giftCardNum: code,
                          ),
                        ),
                      ));
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffc2c2c2),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        'Preview Gift Card',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      endIndent: 10, // Space before the text
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Proceed to Payment",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 10, // Space after the text
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Payable Amount: ',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$$ammount',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Wrap(
                alignment: WrapAlignment.center, // Center the content
                children: [
                  Text(
                    'By proceeding, I accept the',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ' Terms and Conditions & Privacy Policies.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (kDebugMode) {
                    print(code);
                  }
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PaymentMethodScreen(
                          paymentData: GiftCard(
                            imageId: cards[selectedIdx],
                            amount: ammount,
                            message: messageController.text,
                            reciverName: nameController.text,
                            reciverPhone: phoneController.text,
                            reciverEmail: emailController.text,
                            senderName: 'Emma Brown',
                            giftCardNum: code,
                          ),
                          paymentType: PaymentType.GiftCard,
                        ),
                      ),
                    );
                  }
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
                      'Pay Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
