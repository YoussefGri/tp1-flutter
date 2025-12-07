import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String imagePath;
  final double size;

  const AvatarWidget({
    Key? key,
    required this.imagePath,
    this.size = 100.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.pinkAccent, width: 2.0),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
      ),
    );
  }
}