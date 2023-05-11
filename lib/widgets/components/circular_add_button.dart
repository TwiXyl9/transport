import 'package:flutter/material.dart';

class CircularAddButton extends StatelessWidget {
  Function callback;
  CircularAddButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.all(20),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.green,
          child: IconButton(
              onPressed: () => callback(),
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              )
          ),
        )
    );
  }
}
