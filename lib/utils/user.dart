class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final double wallet;
  final String number;
  final List<String> bookedRides; // List of ride IDs (Strings)
  final List<String> publishedRides; // List of ride IDs (Strings)

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.wallet,
    required this.number,
    required this.bookedRides,
    required this.publishedRides,
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
      'bookedRides': bookedRides,
      'publishedRides': publishedRides,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '', // Handle null and fallback to empty string
      name: json['name'] ?? '', // Handle null and fallback to empty string
      email: json['email'] ?? '', // Handle null and fallback to empty string
      image: json['image'] ?? '', // Handle null and fallback to empty string
      number: json['number'] ?? '', // Handle null and fallback to empty string
      wallet: (json['wallet'] as num?)?.toDouble() ??
          0.0, // Safely convert to double

      // Check if bookedRides is a String or a List, and handle accordingly
      bookedRides: (json['bookedRides'] is String)
          ? [json['bookedRides']] // If it's a String, wrap it in a List
          : List<String>.from(
              json['bookedRides'] ?? []), // Otherwise, treat it as a List

      // Same handling for publishedRides
      publishedRides: (json['publishedRides'] is String)
          ? [json['publishedRides']] // If it's a String, wrap it in a List
          : List<String>.from(
              json['publishedRides'] ?? []), // Otherwise, treat it as a List
    );
  }
}
