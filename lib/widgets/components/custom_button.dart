import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  Function()? onTap;
  Color btnColor;
  CustomButton({super.key, required this.btnText, required this.onTap, required this.btnColor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(25),
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
