import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../constants/font_style_mgr.dart';

class CircleIndicator extends StatelessWidget {
  final Color mainFilledCircleColor;

  final Color secondFilledCircleColor;

  final double percent;
  final double radius;

  var mainArcColor;

  var secondArcColor;

  CircleIndicator({
    Key? key,
    required this.mainFilledCircleColor,
    required this.secondFilledCircleColor,
    required this.percent,
    this.radius = 90.0,
    required this.mainArcColor,
    required this.secondArcColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      arcBackgroundColor: Colors.grey[800],
      arcType: ArcType.FULL,
      radius: 90.0,
      lineWidth: 9.0,
      animation: true,
      animationDuration: 1600,
      percent: percent,
      center: Container(
        width: 125,
        height: 125,
        decoration: BoxDecoration(
          color: mainFilledCircleColor,
          // Gradientcolor
          gradient: LinearGradient(
            colors: [
              secondFilledCircleColor,
              mainFilledCircleColor,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.5],
          ),

          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: mainFilledCircleColor,
              blurRadius: 24.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            "${(percent * 100).toInt()}",
            style: TextStyle(
              fontSize: 80,
              fontFamily: 'digital-7',
              color: Colors.white,
            ),
          ),
        ),
      ),
      footer: new Text(
        "نسبة المقروء من القرآن",
        style: new TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12.0,
          color: Colors.grey[400],
          fontFamily: 'Noto_Kufi_Arabic',
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      linearGradient: LinearGradient(
        colors: [
          secondArcColor,
          mainArcColor,
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ),
    );
  }
}
