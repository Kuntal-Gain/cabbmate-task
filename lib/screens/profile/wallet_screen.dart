import 'dart:math';
import 'package:cabmate_task/models/transaction.dart';
import 'package:cabmate_task/screens/payment/payment_method_screen.dart';
import 'package:cabmate_task/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cabmate_task/utils/user.dart';
import 'package:flutter_datetime_format/flutter_datetime_format.dart' as fd;

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String generateTxnId() {
    final random = Random();
    final randomNumber =
        random.nextInt(1000000); // Generates a number between 0 and 999999
    final txnId =
        'Txn${randomNumber.toString().padLeft(6, '0')}'; // Ensure it's 6 digits long
    return txnId;
  }

  void _showAddMoneyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        double num = 0; // Move num inside the bottom sheet builder

        return StatefulBuilder(
          builder: (context, setModalState) {
            // Use StatefulBuilder to manage state inside the modal
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Choose an Action',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Minus button for withdrawing
                      _buildBottomSheetAction(
                        icon: Icons.remove,
                        label: 'Minus',
                        onTap: () {
                          if (num > 0) {
                            setModalState(() {
                              // Update the modal state
                              num--;
                            });
                          }
                        },
                      ),

                      // Display current value of num
                      Text(
                        '\$ $num',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Plus button for adding money
                      _buildBottomSheetAction(
                        icon: Icons.add,
                        label: 'Plus',
                        onTap: () {
                          setModalState(() {
                            // Update the modal state
                            num++;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PaymentMethodScreen(
                            paymentType: PaymentType.Wallet,
                            paymentData: TransactionModel(
                                txnId: generateTxnId(),
                                ammt: num,
                                dateOfTransaction: DateTime.now(),
                                sender: FirebaseAuth.instance.currentUser!.uid,
                                isCredit: true),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          'Add Money',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Method to build individual bottom sheet action buttons
  Widget _buildBottomSheetAction(
      {required IconData icon,
      required String label,
      required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blue,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  List<TransactionModel> transactions = [];
  double walletBalance = 0.0;

  void fetchTransactions() async {
    List<TransactionModel> items = [];

    items = await FirebaseService()
        .fetchTransactionsByUid(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      transactions = items;
    });
  }

  void fetchWalletBalance() async {
    final userModel;

    userModel = await FirebaseService()
        .fetchUser(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      walletBalance = userModel['wallet'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTransactions();
    fetchWalletBalance();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Wallet',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance
            Container(
              height: 260,
              width: double.infinity,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${walletBalance}',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Balance',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Button Section
                  Container(
                    height: 101,
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Open Bottom Sheet when "Add Money" is tapped
                            _showAddMoneyBottomSheet(context);
                          },
                          child: _buildActionButton(Icons.money, 'Add Money'),
                        ),
                        _buildActionButton(Icons.arrow_forward, 'Transfer'),
                        _buildActionButton(Icons.history, 'Transactions'),
                        _buildActionButton(Icons.contact_mail, 'Contact Us'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Recent Transactions Section
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // TabBar for All, Credit, and Debit transactions
            const TabBar(
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Credit'),
                Tab(text: 'Debit'),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
            ),

            // Expanded to handle TabBarView's height dynamically
            Expanded(
              child: TabBarView(
                children: [
                  // Child for "All" tab
                  _buildAllTransactionsTab(),
                  // Child for "Credit" tab
                  _buildCreditTransactionsTab(),
                  // Child for "Debit" tab
                  _buildDebitTransactionsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build action buttons
  Widget _buildActionButton(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build the "All" transactions tab
  Widget _buildAllTransactionsTab() {
    return transactions.isEmpty
        ? Center(child: Text('No transactions found.'))
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text(transaction.isCredit
                    ? 'Added ${transaction.ammt}'
                    : 'Spent ${transaction.ammt}'),
                subtitle: Text(fd.FLDateTime.formatWithNames(
                    transaction.dateOfTransaction, 'DD MMMM , YYYY (EEE)')),
              );
            },
          );
  }

  // Method to build the "Credit" transactions tab
  Widget _buildCreditTransactionsTab() {
    final creditTransactions =
        transactions.where((txn) => txn.isCredit).toList();
    return creditTransactions.isEmpty
        ? Center(child: Text('No credit transactions found.'))
        : ListView.builder(
            itemCount: creditTransactions.length,
            itemBuilder: (context, index) {
              final transaction = creditTransactions[index];
              return Container(
                margin: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.arrow_downward_rounded,
                            color: Colors.white)),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ammount Credited \$${transaction.ammt} by User via Wallet',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(fd.FLDateTime.formatWithNames(
                              transaction.dateOfTransaction,
                              'DD MMMM , YYYY (EEE)')),
                        ],
                      ),
                    ),
                    Text(
                      '\$ ${transaction.ammt}',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }

  // Method to build the "Debit" transactions tab
  Widget _buildDebitTransactionsTab() {
    final debitTransactions =
        transactions.where((txn) => !txn.isCredit).toList();
    return debitTransactions.isEmpty
        ? Center(child: Text('No debit transactions found.'))
        : ListView.builder(
            itemCount: debitTransactions.length,
            itemBuilder: (context, index) {
              final transaction = debitTransactions[index];
              return ListTile(
                title: Text('Spent ${transaction.ammt}'),
                subtitle: Text(fd.FLDateTime.formatWithNames(
                    transaction.dateOfTransaction, 'DD MMMM , YYYY (EEE)')),
              );
            },
          );
  }
}
