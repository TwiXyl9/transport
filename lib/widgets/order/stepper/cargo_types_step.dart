import 'package:flutter/material.dart';
import 'package:transport/models/cargo_type.dart';

class CargoTypesStep extends StatelessWidget {
  List<CargoType> types;
  int value;
  Function callback;
  CargoTypesStep({Key? key, required this.types, required this.value, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        hint: Text("Выберите груз"),
        value: value > 0 ? value : null,
          isExpanded: true,
          items: getItems,
          onChanged: (val)=>{
            callback(val)
          }
      ),
    );
  }

  List<DropdownMenuItem<int>> get getItems{
    List<DropdownMenuItem<int>> menuItems = [];
    types.forEach((type) {
      var item = DropdownMenuItem(child: Text(type.name), value: type.id,);
      menuItems.add(item);
    });
    return menuItems;
  }
}
