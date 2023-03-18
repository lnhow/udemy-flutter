import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:places/helpers/db.dart';
import 'package:places/models/place.dart';

class PlacesProvider with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get places {
    return [..._items];
  }

  void add(Place place) {
    final newPlace = place.clone(id: DateTime.now().toIso8601String());
    _items.add(newPlace);
    notifyListeners();
    DB.upsert(Tables.places, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> loadData() async {
    final list = await DB.list(Tables.places);
    _items.clear();
    _items.addAll(list.map((e) => Place(
        id: e['id'],
        title: e['title'],
        location: Location(address: '', lattitude: 0, longitude: 0),
        image: File(e['image']))));
    notifyListeners();
  }
}
