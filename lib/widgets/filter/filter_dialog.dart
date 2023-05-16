import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../config/order_stages_config.dart';

class FilterDialog extends StatelessWidget {
  MultiSelectController<String> stageController;
  Function callback;
  FilterDialog(this.stageController, this.callback);

  @override
  Widget build(BuildContext context) {

    void clearFilter() {
      stageController.deselectAll();
    }

    void applyFilter() {
      Navigator.of(context).pop();
    }

    return Dialog(
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          constraints: BoxConstraints(minHeight: 50, maxHeight: 400, minWidth: 300, maxWidth: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                  child: Text("Фильтр", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)
              ),
              SizedBox(height: 10,),
              Text("Статусы заявок", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
              SizedBox(height: 10,),
              MultiSelectContainer(
                controller: stageController,
                itemsDecoration: MultiSelectDecorations(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.blueAccent.withOpacity(0.1),
                          Colors.yellow.withOpacity(0.1),
                        ]),
                        border: Border.all(color: Colors.blue[200]!),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  prefix: MultiSelectPrefix(
                      selectedPrefix: const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                  ),
                  items: stages.map((e) => MultiSelectCard(value: e, label: e)).toList(),
                  onChange: (allSelectedItems, selectedItem) {
                    print(stageController.getSelectedItems());
                  }
              ),
              Divider(),
              Text("Машины", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
              SizedBox(height: 10,),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: TextButton(
                        onPressed: clearFilter,
                        child: Text("Очистить", style: TextStyle(color: Colors.white))
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: TextButton(
                        onPressed: applyFilter,
                        child: Text("Применить", style: TextStyle(color: Colors.white))
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
