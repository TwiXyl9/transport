import 'package:flutter/material.dart';
import 'package:transport/widgets/components/page_header_text.dart';

import '../../models/service.dart';
import '../../models/user.dart';
import 'additional_service_item_view.dart';

class AdditionalServiceListView extends StatelessWidget {
  List<Service> services = [];
  User user;
  AdditionalServiceListView(this.services, this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeaderText(text: "Дополнительные услуги"),
        SizedBox(height: 10,),
        ListView(
          shrinkWrap: true,
          children: services.map((e) => AdditionalServiceItemView(e, user)).toList(),
        ),
      ],
    );
  }
}
