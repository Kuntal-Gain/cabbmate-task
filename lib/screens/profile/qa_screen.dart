import 'package:flutter/material.dart';

class FQAScreen extends StatefulWidget {
  const FQAScreen({super.key});

  @override
  State<FQAScreen> createState() => _FQAScreenState();
}

class _FQAScreenState extends State<FQAScreen> {
  List<String> faqs = [
    'How to signup as User',
    'Why do we use it',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'FAQ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (ctx, idx) {
          final quest = faqs[idx];
          return Container(
            height: 70,
            width: double.infinity,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xffc2c2c2)),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(quest),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffc2c2c2),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
