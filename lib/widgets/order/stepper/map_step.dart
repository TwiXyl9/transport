import 'package:flutter/material.dart';
import 'package:transport/widgets/map/map_view.dart';

class MapStep extends StatelessWidget {
  //final TextEditingController dateController;
  final GlobalKey<FormState> formKey;
  final Function callback;
  const MapStep(this.formKey, this.callback);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
        child: MapView(callback: callback)
    );
  }
}
