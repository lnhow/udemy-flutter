import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places/helpers/map.dart';
import 'package:places/pages/places/map.dart';

class InputLocation extends StatefulWidget {
  final Function(double, double) onSelectLocationSuccess;

  const InputLocation(this.onSelectLocationSuccess, {super.key});

  @override
  State<InputLocation> createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocation> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    try {
      final location = await Location().getLocation();
      _updateLocation(location.latitude!, location.longitude!);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void _updateLocation(double latitude, double longitude) {
    final previewUrl = MapService.getPreviewLocationImageUrl(
        latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageUrl = previewUrl;
    });
    widget.onSelectLocationSuccess(
      latitude,
      longitude,
    );
  }

  Future<void> _selectLocation() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
            fullscreenDialog: true, builder: (context) => const PageMap()));
    if (selectedLocation == null) {
      return;
    }
    _updateLocation(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {
                _getCurrentLocation();
              },
              icon: const Icon(Icons.location_on),
              label: const Text('Current location'),
            ),
            TextButton.icon(
              onPressed: () {
                _selectLocation();
              },
              icon: const Icon(Icons.map),
              label: const Text('Select location'),
            ),
          ],
        )
      ],
    );
  }
}
