import 'package:flutter/material.dart';
import 'package:the_arabic_guide_app/screens/Books/Books_library.dart';
import 'package:the_arabic_guide_app/screens/Profile/Profile.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';
import 'package:the_arabic_guide_app/utils/routes.dart';
import 'package:the_arabic_guide_app/utils/sizeConfig.dart';
import 'package:the_arabic_guide_app/screens/Home/Widgets/Custom_Body.dart';

import '../../widgets/customNavigationBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: SizeConfig.blockH! * 10,
        backgroundColor: kPrimaryColor,
        title: const Center(
          child: Column(
            children: [
              Text(
                "السلام علیکم",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Rabia",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipOval(
            child: Image.asset(
              'assets/images/arabicguidIcon.png',
              width: 40, // Adjust the size as needed
              height: 40,
              fit: BoxFit.cover, // Ensures the image fills the circle
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.notification);
              },
              icon: Badge.count(
                backgroundColor: Colors.teal[600],
                count: 22,
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              )),
          SizedBox(
            width: SizeConfig.blockW! * 2,
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          CustomBody(),
          BooksLibrary(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
