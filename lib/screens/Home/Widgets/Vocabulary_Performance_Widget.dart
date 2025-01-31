import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';
import 'package:the_arabic_guide_app/utils/sizeConfig.dart';

class VocabularyPerformanceWidget extends StatelessWidget {
  final int learned;
  final int revisable;
  final int reviewing;

  const VocabularyPerformanceWidget({
    Key? key,
    required this.learned,
    required this.revisable,
    required this.reviewing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widgetHeight = SizeConfig.blockH! * 22;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: widgetHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Bars Section

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProgressBar(
                    "Learned", learned, Colors.teal, learned.toString()),
                SizedBox(height: 10),
                _buildProgressBar(
                    "Revisable", revisable, Colors.pink, revisable.toString()),
                SizedBox(height: 10),
                _buildProgressBar(
                    "Latest", reviewing, Colors.yellow, reviewing.toString()),
              ],
            ),
            // Circular Progress Section
            CircularPercentIndicator(
              radius: widgetHeight * 0.3,
              lineWidth: 12.0,
              percent: (learned + revisable + reviewing) / 300,
              center: Text(
                  "${((learned + revisable + reviewing) / 300 * 100).toStringAsFixed(1)}%",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              progressColor: Colors.teal,
              backgroundColor: Colors.grey.shade200,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(
      String label, int percentage, Color color, String count) {
    return Row(
      children: [
        Text(count, style: TextStyle(color: kdark)),
        SizedBox(width: 10),
        Container(
          width: SizeConfig.blockW! * 10,
          height: SizeConfig.blockH! * 1,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(color: kdark),
        ),
      ],
    );
  }
}
