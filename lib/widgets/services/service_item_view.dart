import 'package:flutter/material.dart';

import '../../models/service.dart';
import '../components/counter_view.dart';

class ServiceItemView extends StatefulWidget {
  final Service service;
  final Map<int,int> selectedServices;
  final Function servicesCallback;

  const ServiceItemView(this.selectedServices, this.servicesCallback, this.service);

  @override
  State<ServiceItemView> createState() => _ServiceItemViewState();
}

class _ServiceItemViewState extends State<ServiceItemView> {
  late Service _service;
  late Map<int,int> _selectedServices;
  late Function _servicesCallback;
  @override
  void initState() {
    _service = widget.service;
    _selectedServices = widget.selectedServices;
    _servicesCallback = widget.servicesCallback;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int count = _selectedServices[_service.id]!;
    setCountCallback(val){
      setState(() {
        _selectedServices[_service.id] = val;
        _servicesCallback(_selectedServices);
      });
    }
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.service.name, style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Цена: ${widget.service.price.toString()} б.р", style: TextStyle(fontSize: 12),),
              ],
            ),
            CounterView(initCount: count, countCallback: setCountCallback,)
          ],
        ),
      ),
    );
  }
}
