import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 60,
                child: Center(
                  child: Icon(
                    Icons.help,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
            ),
            const Text(
              'How can we help you ?',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Your feedback is very important to us. We consider your feedback very seriously and work hard to provide you with the best possible solution at the earliest',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 370,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: const Color(0xffc2c2c2)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 20,
                    ),
                    child: Text(
                      "What's your feedback about?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tap to Write',
                          hintStyle: TextStyle(
                            color: Color(0xffc2c2c2),
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 20,
                    ),
                    child: Text(
                      "Please tell us something went in detail",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tap to Write',
                          hintStyle: TextStyle(
                            color: Color(0xffc2c2c2),
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
