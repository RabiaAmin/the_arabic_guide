import 'package:flutter/material.dart';
import 'package:the_arabic_guide_app/utils/sizeConfig.dart';

class MyCard extends StatelessWidget {
  final String text;
  final String? backgroundImage;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final Color? bgColor;
  final double CardWidth;
  final bool iconShow;

  const MyCard(
      {super.key,
      required this.text,
      this.iconShow = true,
      this.backgroundImage,
      this.backgroundColor =
          Colors.grey, // Default color if no background image
      this.onTap,
      this.bgColor,
      this.CardWidth = double.infinity});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widgetHeight = SizeConfig.blockH! * 9;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: InkWell(
        onTap: onTap, // Optional tap functionality
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Background image or color
              SizedBox(
                height: widgetHeight,
                width: CardWidth,
                child: backgroundImage != null
                    ? Image.asset(
                        backgroundImage!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: backgroundColor,
                      ),
              ),
              // Overlay container for text and icon
              Container(
                height: widgetHeight,
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text widget
                    Text(
                      text,
                      style: TextStyle(
                        color: bgColor,
                        fontSize: SizeConfig.blockH! * 2.01,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Icon widget
                    if (iconShow)
                      Icon(
                        Icons.quiz,
                        color: Colors.white,
                        size: SizeConfig.blockH! * 4,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
