import 'package:flutter/material.dart';
import 'package:transport/models/cargo_type.dart';

import '../../config/order_stages_config.dart';

class StatusDropdown extends StatelessWidget {
  String value;
  Function callback;
  StatusDropdown(this.value, this.callback);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        hint: Text("Выберите статус"),
        items: stages.map((e) => DropdownMenuItem(child: Text(e), value: e,)).toList(),
        value: value,
        isExpanded: true,
        onChanged: (val)=>{
          callback(val)
        }
    );
  }
}
