import 'package:flutter/material.dart';
import 'package:transport/widgets/map/map_view.dart';
import 'package:google_maps_webservice/places.dart';

class MapStep extends StatelessWidget {
  //final TextEditingController dateController;
  final PlaceDetails departure;
  final PlaceDetails arrival;
  final GlobalKey<FormState> formKey;
  final Function callback;
  const MapStep(this.departure, this.arrival, this.formKey, this.callback);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
        child: MapView(departure: departure, arrival: arrival, callback: callback)
    );
  }
}
