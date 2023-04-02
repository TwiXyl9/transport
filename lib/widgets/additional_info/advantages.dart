import 'package:flutter/material.dart';

class AdvantagesView extends StatelessWidget {
  const AdvantagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("Мы очень крутая супер компания!"),
        ],
      ),
    );
  }
}
