import 'package:flutter/material.dart';

import '../../models/service.dart';

class ServiceItemView extends StatelessWidget {
  final Service service;

  const ServiceItemView(this.service);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Checkbox(
              value: value,
              onChanged: onChanged
          ),
          Text(service.name),
          TextField()
        ],
      ),
    );
  }
}
