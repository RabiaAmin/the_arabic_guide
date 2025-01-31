import 'package:flutter/material.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';

class CustomBottomNavBar extends StatefulWidget {
  final Function(int) onTap;
  const CustomBottomNavBar({Key? key, required this.onTap}) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: KBaseColor,
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      onTap: _onItemTapped,
      items: [
        _buildNavItem(Icons.home, "Home", 0),
        _buildNavItem(Icons.menu_book_sharp, "Library", 1),
        _buildNavItem(Icons.person, "profile", 2),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: isSelected ? 8.0 : 0.0),
        child: Icon(icon, color: isSelected ? kPrimaryColor : kdark),
      ),
      label: isSelected ? label : "",
    );
  }
}
