import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place.dart';

class PageMap extends StatefulWidget {
  static const route = '/places/map';
  final Location initialLocation;
  final bool selectable;

  const PageMap(
      {super.key,
      this.initialLocation = const Location(
          lattitude: 15.9030623, longitude: 105.8066925, address: ''),
      this.selectable = true});

  @override
  State<PageMap> createState() => _PageMapState();
}

class _PageMapState extends State<PageMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select location'),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
              zoom: 8,
              target: LatLng(
                widget.initialLocation.lattitude,
                widget.initialLocation.longitude,
              )),
        ));
  }
}
