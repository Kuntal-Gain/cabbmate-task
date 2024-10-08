class NotificationModel {
  final String label;
  final String description;
  final String createAt;
  final Category category;

  NotificationModel({
    required this.label,
    required this.description,
    required this.createAt,
    required this.category,
  });
}

// ignore: constant_identifier_names
enum Category { Notifications, News }
