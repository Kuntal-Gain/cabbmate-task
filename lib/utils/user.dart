class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final double wallet;
  final String number;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.wallet,
    required this.number,
  });

  // Convert a UserModel object into a Map (JSON format)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
      'wallet': wallet,
      'number': number,
    };
  }

  // Create a UserModel object from a Map (typically from Firestore)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      number: json['number'] ?? '',
      wallet: (json['wallet'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
