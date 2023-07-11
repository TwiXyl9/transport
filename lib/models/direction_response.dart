import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

class DirectionsResponse {
  List<Routes>? routes;
  String? status;

  DirectionsResponse({this.routes, this.status});

  DirectionsResponse.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(Routes.fromJson(v));
      });
    }
    status = json['status'];
  }

}

class Routes {
  Bounds? bounds;
  String? copyrights;
  List<Legs>? legs;
  MyPolyline? overviewPolyline;
  String? summary;

  Routes(
      {this.bounds,
        this.copyrights,
        this.legs,
        this.overviewPolyline,
        this.summary,});

  Routes.fromJson(Map<String, dynamic> json) {
    bounds =
    json['bounds'] != null ? Bounds.fromJson(json['bounds']) : null;
    copyrights = json['copyrights'];
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(Legs.fromJson(v));
      });
    }
    overviewPolyline = json['overview_polyline'] != null
        ? MyPolyline.fromJson(json['overview_polyline'])
        : null;
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bounds != null) {
      data['bounds'] = bounds!.toJson();
    }
    data['copyrights'] = copyrights;
    if (legs != null) {
      data['legs'] = legs!.map((v) => v.toJson()).toList();
    }
    if (overviewPolyline != null) {
      data['overview_polyline'] = overviewPolyline!.toJson();
    }
    data['summary'] = summary;

    return data;
  }
}

class Bounds {
  Northeast? northeast;
  Northeast? southwest;

  Bounds({this.northeast, this.southwest});

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? Northeast.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? Northeast.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast!.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest!.toJson();
    }
    return data;
  }
}

class Northeast {
  double? lat;
  double? lng;

  Northeast({this.lat, this.lng});

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Legs {
  Distance? distance;
  Distance? duration;
  String? endAddress;
  Northeast? endLocation;
  String? startAddress;
  Northeast? startLocation;
  List<Steps>? steps;

  Legs(
      {this.distance,
        this.duration,
        this.endAddress,
        this.endLocation,
        this.startAddress,
        this.startLocation,
        this.steps,});

  Legs.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? Distance.fromJson(json['duration'])
        : null;
    endAddress = json['end_address'];
    endLocation = json['end_location'] != null
        ? Northeast.fromJson(json['end_location'])
        : null;
    startAddress = json['start_address'];
    startLocation = json['start_location'] != null
        ? Northeast.fromJson(json['start_location'])
        : null;
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    data['end_address'] = endAddress;
    if (endLocation != null) {
      data['end_location'] = endLocation!.toJson();
    }
    data['start_address'] = startAddress;
    if (startLocation != null) {
      data['start_location'] = startLocation!.toJson();
    }
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    return data;
  }
}

class Steps {
  Distance? distance;
  Distance? duration;
  Northeast? endLocation;
  String? htmlInstructions;
  MyPolyline? polyline;
  Northeast? startLocation;
  String? travelMode;
  String? maneuver;

  Steps(
      {this.distance,
        this.duration,
        this.endLocation,
        this.htmlInstructions,
        this.polyline,
        this.startLocation,
        this.travelMode,
        this.maneuver});

  Steps.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? Distance.fromJson(json['duration'])
        : null;
    endLocation = json['end_location'] != null
        ? Northeast.fromJson(json['end_location'])
        : null;
    htmlInstructions = json['html_instructions'];
    polyline = json['polyline'] != null
        ? MyPolyline.fromJson(json['polyline'])
        : null;
    startLocation = json['start_location'] != null
        ? Northeast.fromJson(json['start_location'])
        : null;
    travelMode = json['travel_mode'];
    maneuver = json['maneuver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    if (endLocation != null) {
      data['end_location'] = endLocation!.toJson();
    }
    data['html_instructions'] = htmlInstructions;
    if (polyline != null) {
      data['polyline'] = polyline!.toJson();
    }
    if (startLocation != null) {
      data['start_location'] = startLocation!.toJson();
    }
    data['travel_mode'] = travelMode;
    data['maneuver'] = maneuver;
    return data;
  }
}

class MyPolyline {
  late List<LatLng> points;

  MyPolyline({ required this.points});

  MyPolyline.fromJson(Map<String, dynamic> json) {
    points = decodePolyline(json['points']).map((e) => LatLng(e[0].toDouble(),e[1].toDouble())).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['points'] = points;
    return data;
  }
}