import 'package:flutter/material.dart';
import 'package:transport/models/cargo_type.dart';

class CargoTypesStep extends StatelessWidget {
  List<CargoType> types;
  CargoType value;
  Function callback;
  CargoTypesStep({Key? key, required this.types, required this.value, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        hint: Text("Выберите груз"),
        value: value.id > 0 ? value : null,
          isExpanded: true,
          items: getItems,
          onChanged: (val)=>{
            callback(val)
          }
      ),
    );
  }

  List<DropdownMenuItem<CargoType>> get getItems{
    List<DropdownMenuItem<CargoType>> menuItems = [];
    types.forEach((type) {
      var item = DropdownMenuItem(child: Text(type.name), value: type,);
      menuItems.add(item);
    });
    return menuItems;
  }
}
