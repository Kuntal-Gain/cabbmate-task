class GiftCard {
  final String imageId;
  final double amount;
  final String message;
  final String reciverName;
  final String reciverPhone;
  final String reciverEmail;
  final String senderName;
  final String giftCardNum;

  GiftCard({
    required this.imageId,
    required this.amount,
    required this.message,
    required this.reciverName,
    required this.reciverPhone,
    required this.reciverEmail,
    required this.senderName,
    required this.giftCardNum,
  });

  // Convert GiftCard object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'imageId': imageId,
      'amount': amount,
      'message': message,
      'reciverName': reciverName,
      'reciverPhone': reciverPhone,
      'reciverEmail': reciverEmail,
      'senderName': senderName,
      // Add more fields as needed
    };
  }

  // Create a GiftCard from a Firestore document
  factory GiftCard.fromMap(String giftCardNum, Map<String, dynamic> data) {
    return GiftCard(
      imageId: data['imageId'],
      amount: data['amount'],
      message: data['message'],
      reciverName: data['reciverName'],
      reciverPhone: data['reciverPhone'],
      reciverEmail: data['reciverEmail'],
      senderName: data['senderName'],
      giftCardNum: giftCardNum,
    );
  }
}
