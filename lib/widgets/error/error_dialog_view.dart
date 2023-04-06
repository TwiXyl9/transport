import 'package:flutter/material.dart';

class ErrorDialogView extends StatelessWidget {
  final BuildContext ctx;
  final String message;
  const ErrorDialogView({Key? key, required this.ctx, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Что-то пошло не так!'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    );
  }
}
