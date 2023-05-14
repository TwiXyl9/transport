import 'package:flutter/material.dart';



class DropdownSortingView extends StatelessWidget {
  Function callback;
  String value;
  DropdownSortingView(this.callback, this.value);

  List<String> sortBy = ['По дате выполнения', 'По новизне'];
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        hint: Text("Выберите груз"),
        value: value,
        isExpanded: true,
        items: getItems,
        onChanged: (val)=>{
          callback(val)
        }
    );
  }
  List<DropdownMenuItem<String>> get getItems{
    List<DropdownMenuItem<String>> menuItems = [];
    sortBy.forEach((type) {
      var item = DropdownMenuItem(child: Text(type), value: type,);
      menuItems.add(item);
    });
    return menuItems;
  }
}
