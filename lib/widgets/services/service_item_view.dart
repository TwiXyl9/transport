import 'package:flutter/material.dart';

import '../../models/service.dart';
import '../components/counter_view.dart';

class ServiceItemView extends StatefulWidget {
  final Service service;

  const ServiceItemView(this.service);

  @override
  State<ServiceItemView> createState() => _ServiceItemViewState();
}

class _ServiceItemViewState extends State<ServiceItemView> {
  @override
  Widget build(BuildContext context) {
    int count = 0;
    setCountCallback(val) {
      setState(() {
        count = val;
      });
    }
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.service.name),
            CounterView(initCount: count, countCallback: setCountCallback,)
          ],
        ),
      ),
    );
  }
}