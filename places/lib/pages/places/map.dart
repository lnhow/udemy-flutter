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
          latitude: 15.9030623, longitude: 105.8066925, address: ''),
      this.selectable = true});

  @override
  State<PageMap> createState() => _PageMapState();
}

class _PageMapState extends State<PageMap> {
  LatLng? _selectedLocation;

  void _selectLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  Set<Marker> getDisplayMarker() {
    if (_selectedLocation != null) {
      return {
        Marker(
            markerId: const MarkerId('Selected'), position: _selectedLocation!)
      };
    }
    if (!widget.selectable) {
      final latlng = LatLng(
          widget.initialLocation.latitude, widget.initialLocation.longitude);
      return {Marker(markerId: const MarkerId('Selected'), position: latlng)};
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Select location'), actions: [
          if (widget.selectable)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(_selectedLocation);
                },
                icon: const Icon(Icons.check))
        ]),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
              zoom: 8,
              target: LatLng(
                widget.initialLocation.latitude,
                widget.initialLocation.longitude,
              )),
          onTap: widget.selectable ? _selectLocation : null,
          markers: getDisplayMarker(),
        ));
  }
}
