import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.3,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
            color: Colors.white,
            image: const DecorationImage(image: AssetImage("assetName.jpg")),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
