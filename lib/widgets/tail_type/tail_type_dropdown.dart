import 'package:flutter/material.dart';

import '../../models/tail_type.dart';

class TailTypeDropdown extends StatelessWidget {
  List<TailType> types;
  TailType selectedType;
  Function callback;
  TailTypeDropdown(this.types, this.selectedType, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: DropdownButton(
          hint: Text("Выберите тип борта"),
          items: getItems,
          value: selectedType.id > 0 ? selectedType : null,
          isExpanded: true,
          onChanged: (val)=>{
            callback(val)
          }
      ),
    );
  }
  List<DropdownMenuItem<TailType>> get getItems{
    List<DropdownMenuItem<TailType>> menuItems = [];
    types.forEach((type) {
      var item = DropdownMenuItem(child: Text(type.name), value: type,);
      menuItems.add(item);
    });
    return menuItems;
  }
}
