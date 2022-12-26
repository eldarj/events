import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapComponent extends StatefulWidget {
  final double latitude;

  final double longitude;

  const MapComponent(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<MapComponent> createState() => MapComponentState();
}

class MapComponentState extends State<MapComponent> {
  Completer<GoogleMapController> mapCompleter = Completer();

  late CameraPosition cameraPosition;

  @override
  void initState() {
    cameraPosition = CameraPosition(
      zoom: 13.5,
      target: LatLng(widget.latitude, widget.longitude),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        initialCameraPosition: cameraPosition,
        markers: {
          Marker(
            position: cameraPosition.target, markerId: const MarkerId('Map'),
          )
        },
        onMapCreated: (GoogleMapController controller) {
          mapCompleter.complete(controller);
        },
      ),
    );
  }
}
