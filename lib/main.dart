import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_arabic_guide_app/models/vocabulary.dart';
import 'package:the_arabic_guide_app/screens/Notification/Notification_Screen.dart';
import 'package:the_arabic_guide_app/screens/vocabulary/Vocab_Screen.dart';
import 'package:the_arabic_guide_app/services/service_locator.dart';

import 'package:the_arabic_guide_app/utils/routes.dart';
import 'package:the_arabic_guide_app/screens/Home/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  await Hive.initFlutter();
  Hive.registerAdapter(VocabularyAdapter());

  // Open necessary Hive boxes before setting up the service locator
  await Hive.openBox<Vocabulary>('vocabularyBox');
  await Hive.openBox<DateTime>('fetchTimestamps');

  // Set up dependencies after Hive is ready
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        Routes.home: (context) => const Home(),
        Routes.notification: (context) => NotificationScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
