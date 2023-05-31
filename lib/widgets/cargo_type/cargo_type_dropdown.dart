import 'package:flutter/material.dart';
import 'package:transport/models/cargo_type.dart';

class CargoTypeDropdown extends StatelessWidget {
  List<CargoType> types;
  CargoType value;
  Function callback;
  CargoTypeDropdown(this.types, this.value, this.callback);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        hint: Text("Выберите груз"),
        items: types.map((e) => DropdownMenuItem(child: Text(e.name), value: e,)).toList(),
        value: value.id > 0 ? value : null,
        isExpanded: true,
        onChanged: (val)=>{
          callback(val)
        }
    );
  }
}
