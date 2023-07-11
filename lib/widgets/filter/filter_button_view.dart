import 'package:flutter/material.dart';

class FilterButtonView extends StatelessWidget {
  Function callback;
  FilterButtonView(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.all(20),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueAccent,
          child: IconButton(
              onPressed: () => callback(),
              icon: Icon(
                Icons.filter_alt,
                color: Colors.white,
                size: 25,
              )
          ),
        )
    );
  }
}
