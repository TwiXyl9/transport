import 'package:flutter/material.dart';

import '../../../models/service.dart';
import '../../services/service_item_view.dart';

class ServicesStep extends StatelessWidget {
  List<Service> services;
  ServicesStep({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          children: services.map((e) => ServiceItemView((e))).toList(),
        ),
      ],
    );
  }
}
