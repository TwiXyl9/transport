import 'package:flutter/services.dart';

List<TextInputFormatter> numFormatter(){
  return <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
    TextInputFormatter.withFunction(
      (oldValue, newValue) => newValue.copyWith(
        text: newValue.text.replaceAll(',', '.'),
      ),
    ),
  ];
}