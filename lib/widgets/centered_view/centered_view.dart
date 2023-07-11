import 'package:flutter/material.dart';

class CenteredView extends StatelessWidget {
  final Widget child;
  const CenteredView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: SingleChildScrollView(
            child: Center(
                child: Container(
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 650),
                    child: child
                )
            )
      ),
    );
  }
}
