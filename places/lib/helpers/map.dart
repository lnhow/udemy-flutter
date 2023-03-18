import 'package:flutter/material.dart';

const apiKey = 'AIzaSyDxVkJBLjhBYjxnGqxMY7uK5OG83nItPdc';

class MapService {
  static String getPreviewLocationImageUrl(
      {required double latitude, required double longitude, zoom = 16}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=$zoom&size=600x300&markers=color:red|$latitude,$longitude&key=$apiKey';
  }
}
