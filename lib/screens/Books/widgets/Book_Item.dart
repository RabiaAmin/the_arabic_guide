import 'package:flutter/material.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';

class BookItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onViewPressed;
  final VoidCallback onDownloadPressed;

  const BookItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onViewPressed,
    required this.onDownloadPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: KBaseColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            Image.asset(
              imageUrl,
              width: 60,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            // Book Title and Buttons
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Download Button
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white),
                        onPressed: onDownloadPressed,
                        child: const Text("Download pdf"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
