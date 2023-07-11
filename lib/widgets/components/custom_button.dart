import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  Function()? onTap;
  Color btnColor;
  double width;
  double margin;
  CustomButton({super.key, required this.btnText, required this.onTap, required this.btnColor, this.width = 200, this.margin = 20});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 50,
        margin: EdgeInsets.all(margin),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),
        ),
      ),
    );
  }
}
