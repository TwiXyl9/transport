import 'package:flutter/material.dart';

import '../../models/cargo_type.dart';
import 'cargo_type_item_view.dart';

class CargoTypeListView extends StatelessWidget {
  List<CargoType> types = [];
  CargoTypeListView(this.types);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: types.map((e) => CargoTypeItemView(e)).toList(),
    );
  }
}
