import 'package:flutter/foundation.dart';
import 'package:places/models/place.dart';

class PlacesProvider with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get place {
    return [..._items];
  }
}
