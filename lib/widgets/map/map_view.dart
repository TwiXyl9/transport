import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:transport/services/direction_service.dart';

import '../../config/secrets.dart';
import '../../models/direction_response.dart';

enum MarkerType {departure, arrival}

class MapView extends StatefulWidget {
  final PlaceDetails departure;
  final PlaceDetails arrival;
  final Function callback;
  const MapView({Key? key, required this.departure, required this.arrival, required this.callback}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  DirectionsResponse directionsResponse = DirectionsResponse();
  late GoogleMapController mapController;
  TextEditingController departureController = TextEditingController();
  TextEditingController arrivalController = TextEditingController();
  List<Marker> markersList = [];
  late String totalDistance;
  late String totalTime;
  bool routeCreated = false;
  final String key = Secrets.API_KEY_PLACES;
  final LatLng _center = const LatLng(53.677839, 23.829529);
  final GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: Secrets.API_KEY_PLACES,
      baseUrl: 'https://maps.googleapis.com/maps/api',
      apiHeaders: {
        'X-Requested-With': 'XMLHttpRequest',
        'Access-Control-Allow-Origin' : '*',
      }
  );

  final List<Polyline> polyline = [];

  late PlaceDetails _departure;
  late PlaceDetails _arrival;

  @override
  void initState() {
    _departure = widget.departure;
    _arrival = widget.arrival;
    if (_departure.name.isNotEmpty && _arrival.name.isNotEmpty) {
      setInitCoordinates();
      computePath();
    }
    super.initState();
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<void> displayPrediction(Prediction p, MarkerType type) async {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry?.location.lat;
    final lng = detail.result.geometry?.location.lng;

    setState(() {
      if (type == MarkerType.departure) {
        _departure = detail.result;
        departureController.text = detail.result.formattedAddress!;
      } else {
        _arrival = detail.result;
        arrivalController.text = detail.result.formattedAddress!;
      }
      Marker marker = Marker(
          markerId: type == MarkerType.departure? const MarkerId('departureMarker') : const MarkerId('arrivalMarker'),
          draggable: false,
          infoWindow: InfoWindow(
            title: type == MarkerType.departure? "Точка отправления" : "Точка прибытия",
          ),
          onTap: () {
            //print('this is where you will arrive');
          },
          position: LatLng(lat!, lng!)
      );
      markersList.add(marker);
    });

    moveCamera(lat!, lng!);

    computePath();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 400,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: Set.from(markersList),
            polylines: Set.from(polyline),
          ),
          Positioned(
              top: 10.0,
              right: 15.0,
              left: 15.0,
              child: Column(
                children: <Widget>[
                  AddressTextField('Точка погрузки', departureController, MarkerType.departure),
                  const SizedBox(
                    height: 10,
                  ),
                  AddressTextField('Точка выгрузки', arrivalController, MarkerType.arrival),
                  const SizedBox(
                    height: 10,
                  ),
                  if (routeCreated) Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Расстояние: ${totalDistance}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Время: ${totalTime}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget AddressTextField(String label, TextEditingController controller, MarkerType type){
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white
        ),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
                enabledBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                alignLabelWithHint: true,
                labelStyle: const TextStyle(color: Colors.black),
              ),
              controller: controller,
              validator: (val){
                if(val!.isEmpty){
                  return 'Введите адрес!';
                }
              },
              onTap: () async {
                Prediction p = (await PlacesAutocomplete.show(
                    context: context,
                    apiKey: key,
                    offset: 0,
                    strictbounds: false,
                    types: [],
                    radius: 1000,
                    mode: Mode.overlay,
                    language: "ru",
                    components: [
                      Component(Component.country, "by")
                    ]))!;
                if (p != null) displayPrediction(p, type);
                FocusScope.of(context).requestFocus(FocusNode());
              },
              //onEditingComplete: searchAndNavigate,
            ),
          ],
        )
    );
  }

  void computePath() async {
    if (_departure.name.isEmpty || _arrival.name.isEmpty) return;
    LatLng origin = LatLng(_departure.geometry!.location.lat, _departure.geometry!.location.lng);
    LatLng end = LatLng(_arrival.geometry!.location.lat, _arrival.geometry!.location.lng);

    directionsResponse = await DirectionService().getSometing(Secrets.API_KEY_PLACES, origin, end);

    totalDistance = directionsResponse.routes![0].legs![0].distance!.text!;
    totalTime = directionsResponse.routes![0].legs![0].duration!.text!;

    setState(() {
      polyline.add(
          Polyline(
              polylineId: const PolylineId(
                  'route'
              ),
              points: directionsResponse.routes![0].overviewPolyline!.points,
              width: 5,
              color: Colors.blue
          )
      );
      routeCreated = true;
    });

    widget.callback(_departure, _arrival);
  }

  void moveCamera(double lat, double lng) {
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(lat, lng),
                zoom: 10.0
            )
        )
    );
  }

  void setMarkers(type, lat, lng) {
    Marker marker = Marker(
        markerId: type == MarkerType.departure? const MarkerId('departureMarker') : const MarkerId('arrivalMarker'),
        draggable: false,
        infoWindow: InfoWindow(
          title: type == MarkerType.departure? "Точка отправления" : "Точка прибытия",
        ),
        onTap: () {},
        position: LatLng(lat!, lng!)
    );
    markersList.add(marker);
  }

  void setInitCoordinates() {
    departureController.text = _departure.formattedAddress!;
    setMarkers(MarkerType.departure, _departure.geometry?.location.lat, _departure.geometry?.location.lng);
    arrivalController.text = _arrival.formattedAddress!;
    setMarkers(MarkerType.arrival, _arrival.geometry?.location.lat, _arrival.geometry?.location.lng);

  }
}
