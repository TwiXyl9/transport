import 'package:flutter/material.dart';

import '../../../models/service.dart';
import '../../services/service_item_view.dart';

class ServicesStep extends StatelessWidget {
  List<Service> services;
  Map<int,int> selectedServices;
  Function servicesCallback;
  ServicesStep({Key? key, required this.selectedServices, required this.servicesCallback, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          children: services.map((e) => ServiceItemView( selectedServices, servicesCallback, e)).toList(),
        ),
      ],
    );
  }
}
