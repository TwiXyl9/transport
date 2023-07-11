import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String text;
  BoldText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
    );
  }
}
