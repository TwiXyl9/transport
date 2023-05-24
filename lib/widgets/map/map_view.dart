import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../config/secrets.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  TextEditingController departureController = new TextEditingController();
  TextEditingController arrivalController = new TextEditingController();
  List<Marker> markersList = [];
  final String key = Secrets.API_KEY;
  LatLng _center = LatLng(53.677839, 23.829529);
  GoogleMapsPlaces _places = GoogleMapsPlaces(
    apiKey: Secrets.API_KEY,
    baseUrl: kIsWeb ?
    'https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api'
      : null);
  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: Secrets.API_KEY);
  final List<Polyline> polyline = [];
  List<LatLng> routeCoords = [];

  late PlaceDetails departure;
  late PlaceDetails arrival;

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<Null> displayPredictionDeparture(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(
          p.placeId!);
      final lat = detail.result.geometry?.location.lat;
      final lng = detail.result.geometry?.location.lng;

      setState(() {
        departure = detail.result;
        departureController.text = detail.result.name;
        Marker marker = Marker(
            markerId: MarkerId('arrivalMarker'),
            draggable: false,
            infoWindow: InfoWindow(
              title: "This is where you will arrive",
            ),
            onTap: () {
              //print('this is where you will arrive');
            },
            position: LatLng(lat!, lng!)
        );
        markersList.add(marker);
      });

      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(lat!, lng!),
          zoom: 10.0
      )));
    }
  }

  Future<Null> displayPredictionArrival(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(
          p.placeId!);
      final lat = detail.result.geometry?.location.lat;
      final lng = detail.result.geometry?.location.lng;

      setState(() {
        arrival = detail.result;
        arrivalController.text = detail.result.name;
        Marker marker = Marker(
            markerId: MarkerId('arrivalMarker'),
            draggable: false,
            infoWindow: InfoWindow(
              title: "This is where you will arrive",
            ),
            onTap: () {
              //print('this is where you will arrive');
            },
            position: LatLng(lat!, lng!)
        );
        markersList.add(marker);
      });

      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(lat!, lng!),
          zoom: 10.0
      )));

      computePath();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white
                        ),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Точка погрузки',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15.0, top: 15.0),
                                // suffixIcon: IconButton(
                                //   icon: Icon(Icons.search),
                                //   iconSize: 30.0,
                                // )
                              ),
                              controller: departureController,
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
                                      new Component(Component.country, "ru")
                                    ]))!;
                                displayPredictionDeparture(p);
                              },
                              //onEditingComplete: searchAndNavigate,
                            ),
                          ],
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white
                        ),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Точка выгрузки',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15.0, top: 15.0),
                                // suffixIcon: IconButton(
                                //   icon: Icon(Icons.search),
                                //   iconSize: 30.0,
                                // )
                              ),
                              controller: arrivalController,
                              onTap: () async {
                                Prediction? p = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: key,
                                    mode: Mode.overlay,
                                    language: "en",
                                    components: [
                                      new Component(Component.country, "en")
                                    ]);
                                displayPredictionArrival(p!);
                              },
                              //onEditingComplete: searchAndNavigate,
                            ),
                          ],
                        )
                    ),
                  ],
                )
            ),
          ],
        ),
    );
  }

  computePath() async{
    LatLng origin = new LatLng(departure.geometry!.location.lat, departure.geometry!.location.lng);
    LatLng end = new LatLng(arrival.geometry!.location.lat, arrival.geometry!.location.lng);
    routeCoords.addAll((await googleMapPolyline.getCoordinatesWithLocation(origin: origin, destination: end, mode: RouteMode.driving))!);

    setState(() {
      polyline.add(Polyline(
          polylineId: PolylineId('iter'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap
      ));
    });
  }
}
