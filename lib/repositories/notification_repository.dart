import 'package:the_arabic_guide_app/models/notificatoin.dart';

class NotificationRepository {
  Future<List<AppNotification>> fetchNotifications() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Sample notification data
    return [
      AppNotification(
        title: "New Course Available",
        description: "A new course on Flutter is now available. Enroll today!",
        timestamp: "5 mins ago",
      ),
      AppNotification(
        title: "Profile Update",
        description: "Your profile has been successfully updated.",
        timestamp: "1 hour ago",
      ),
      AppNotification(
        title: "Subscription Expired",
        description:
            "Your subscription has expired. Renew to continue accessing content.",
        timestamp: "2 days ago",
      ),
      AppNotification(
        title: "Welcome!",
        description: "Welcome to our app! We're excited to have you onboard.",
        timestamp: "3 days ago",
      ),
    ];
  }
}
