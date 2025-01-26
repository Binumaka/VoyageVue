import 'package:flutter/material.dart';

Widget buildImageContainer(
  BuildContext context,
  Color color,
  String title,
  String subtitle,
  String imagePath, {
  bool isCircular = false,
  double? imageWidth,
  double? imageHeight,
}) {
  return SafeArea(
    child: Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: imageWidth ?? MediaQuery.of(context).size.width * 0.8,
              height: imageHeight ?? MediaQuery.of(context).size.height * 0.39,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'GreatVibes Regular',
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'SansSerif',
                  fontSize: 14,
                  color: Color.fromARGB(255, 93, 71, 65),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
