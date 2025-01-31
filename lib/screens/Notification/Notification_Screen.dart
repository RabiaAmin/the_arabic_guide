import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:the_arabic_guide_app/models/notificatoin.dart';
import 'package:the_arabic_guide_app/repositories/notification_repository.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationRepository notificationRepository =
      GetIt.I<NotificationRepository>();
  late Future<List<AppNotification>> notificationsFuture;

  @override
  void initState() {
    super.initState();
    notificationsFuture = notificationRepository.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: FutureBuilder<List<AppNotification>>(
        future: notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No notifications found."));
          } else {
            final notifications = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      notification.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(notification.description),
                        const SizedBox(height: 4),
                        Text(
                          notification.timestamp,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                    leading:
                        const Icon(Icons.notifications, color: Colors.teal),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
