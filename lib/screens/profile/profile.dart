import 'package:cabmate_task/screens/giftcard/gift_card_screen.dart';
import 'package:cabmate_task/screens/profile/contact_us.dart';
import 'package:cabmate_task/screens/profile/notification_screen.dart';
import 'package:cabmate_task/screens/profile/qa_screen.dart';

import 'package:cabmate_task/screens/profile/verify_email_screen.dart';
import 'package:cabmate_task/service/firebase_service.dart';
import 'package:cabmate_task/utils/user.dart';
import 'package:cabmate_task/widgets/profile_card_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/wallet_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSwitched = false;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseService srv = FirebaseService();
  late UserModel _user;

  @override
  void initState() {
    super.initState();

    srv.fetchUser(uid).then((userData) {
      if (userData != null) {
        setState(() {
          _user = UserModel.fromJson(userData); // Converting Map to User object
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 35,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 45,
                              backgroundImage:
                                  AssetImage('assets/images/img_1.png'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _user.name,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    _user.email,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (!FirebaseAuth
                                      .instance.currentUser!.emailVerified)
                                    IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    AccountVerificationScreen(),
                                              ),
                                            ),
                                        icon: const Icon(
                                          Icons.info,
                                          color: Colors.red,
                                        ))
                                ],
                              ),
                              Text(
                                _user.number,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffc2c2c2),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Wallet Balance',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '\$${_user.wallet}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              walletTile(
                                Icons.wallet,
                                "Wallet",
                                Colors.pink,
                                Container(),
                                context,
                              ),
                              walletTile(
                                Icons.account_balance_wallet,
                                "Top Up",
                                Colors.purple,
                                Container(),
                                context,
                              ),
                              walletTile(
                                Icons.inbox,
                                "Invite",
                                Colors.orange,
                                Container(),
                                context,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "General Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            profileCardTile(Colors.brown, "About You", Icons.person),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const NotificationScreen())),
              child: profileCardTile(
                  Colors.deepPurple, "Notifications", Icons.notifications),
            ),
            profileCardTile(Colors.orange, "Invite Friends", Icons.inbox),
            profileCardTile(Colors.greenAccent.shade100, "Emergency Contacts",
                Icons.call_rounded),
            profileCardTile(Colors.green, "Donate", Icons.how_to_vote),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Accounts Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.cyan,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/5107/5107483.png',
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text('Enable Face ID/Touch ID'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: _isSwitched,
                    onChanged: (value) {
                      setState(() {
                        _isSwitched = value;
                      });
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                  ),
                  const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                    size: 30,
                  ),
                ],
              ),
            ),
            profileCardTile(Colors.pink, "Manage Account", Icons.person),
            profileCardTile(Colors.green, "Change Password", Icons.password),
            profileCardTile(Colors.yellow, "Change Currency",
                Icons.currency_exchange_sharp),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Payment",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
                child: profileCardTile(
                    Colors.red, "Payment Method", Icons.payment)),
            GestureDetector(
              onTap: () {},
              child: profileCardTile(Colors.blue, "My Wallet", Icons.wallet),
            ),
            profileCardTile(Colors.orange, "Add Money", Icons.money),
            profileCardTile(Colors.greenAccent, "Send Money", Icons.money),
            const Padding(padding: EdgeInsets.all(10)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Gift Card",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const GiftCardScreen())),
              child: profileCardTile(
                  Colors.brown, "Send Gift Card", Icons.wallet_giftcard),
            ),
            profileCardTile(
                Colors.blue, "Redeem Gift Card", Icons.card_giftcard),
            const Padding(padding: EdgeInsets.all(10)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Support",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            profileCardTile(Colors.yellow, "About us", Icons.info),
            profileCardTile(Colors.black, "Privacy Policy", Icons.privacy_tip),
            profileCardTile(
                Colors.redAccent, "Terms & Conditions", Icons.file_open),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const FQAScreen()));
              },
              child: profileCardTile(
                  Colors.pinkAccent, "FAQ", Icons.question_mark_outlined),
            ),
            profileCardTile(Colors.greenAccent, "Live Chat", Icons.chat),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const ContactUsPage(),
                  ),
                );
              },
              child: profileCardTile(
                  Colors.orangeAccent, "Contact Us", Icons.question_answer),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Other",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
                onTap: () => FirebaseAuth.instance.signOut(),
                child:
                    profileCardTile(Colors.blueAccent, "Logout", Icons.logout)),
          ],
        ),
      ),
    );
  }
}
