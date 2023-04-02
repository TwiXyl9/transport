import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imgPath;
  const ImageContainer({Key? key, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(imgPath, height: 40),
    );
  }
}
