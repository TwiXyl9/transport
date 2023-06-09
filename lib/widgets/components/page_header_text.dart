import 'package:flutter/material.dart';

class PageHeaderText extends StatelessWidget {
  final String text;
  const PageHeaderText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
        child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white
            )
        )
    );
  }
}
