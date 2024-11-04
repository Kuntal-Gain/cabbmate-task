import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String txnId;
  final double ammt;
  final DateTime dateOfTransaction;
  final String sender;
  final bool isCredit;

  TransactionModel({
    required this.txnId,
    required this.ammt,
    required this.dateOfTransaction,
    required this.sender,
    required this.isCredit,
  });

  // Optionally, you can include methods like toMap and fromMap for Firebase or other database integrations
  Map<String, dynamic> toMap() {
    return {
      'txnId': txnId,
      'ammt': ammt,
      'dateOfTransaction': dateOfTransaction.toIso8601String(),
      'sender': sender,
      'isCredit': isCredit,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      txnId: map['txnId'] ?? '',
      ammt: map['ammt']?.toDouble() ?? 0.0,
      dateOfTransaction: DateTime.parse(map['dateOfTransaction']),
      sender: map['sender'] ?? '',
      isCredit: map['isCredit'] ?? false,
    );
  }
  factory TransactionModel.fromDocument(DocumentSnapshot doc) {
    return TransactionModel(
      txnId: doc['txnId'],
      ammt: (doc['ammt'] as num).toDouble(), // Ensure it's double
      dateOfTransaction: (doc['dateOfTransaction'] as Timestamp)
          .toDate(), // Convert Timestamp to DateTime
      sender: doc['sender'],
      isCredit: doc['isCredit'],
    );
  }
}
