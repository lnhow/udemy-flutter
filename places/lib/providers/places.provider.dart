import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:places/helpers/db.dart';
import 'package:places/helpers/map.dart';
import 'package:places/models/place.dart';

class PlacesProvider with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get places {
    return [..._items];
  }

  Place getPlace(String id) {
    final place = _items.firstWhere((element) => element.id == id);
    return place;
  }

  Future<void> add(Place place) async {
    final location = place.location;
    final address =
        await MapService.getGeocode(location.latitude, location.longitude);
    final newPlace = place.clone(
        id: DateTime.now().toIso8601String(),
        location: Location(
            latitude: location.latitude,
            longitude: location.longitude,
            address: address));
    _items.add(newPlace);
    notifyListeners();
    DB.upsert(Tables.places, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': location.latitude,
      'lng': location.longitude,
      'address': address
    });
  }

  Future<void> loadData() async {
    final list = await DB.list(Tables.places);
    _items.clear();
    _items.addAll(list.map((e) => Place(
        id: e['id'],
        title: e['title'],
        location: Location(
            address: e['address'], latitude: e['lat'], longitude: e['lng']),
        image: File(e['image']))));
    notifyListeners();
  }
}
