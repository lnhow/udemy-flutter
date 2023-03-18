import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = 'AIzaSyDxVkJBLjhBYjxnGqxMY7uK5OG83nItPdc';

class MapService {
  static String getPreviewLocationImageUrl(
      {required double latitude, required double longitude, zoom = 16}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=$zoom&size=600x300&markers=color:red|$latitude,$longitude&key=$apiKey';
  }

  static Future<String> getGeocode(double latitude, double longitude) async {
    final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');
    final res = await http.get(uri);
    final address = json.decode(res.body)['results'][0]['formatted_address'];
    return address;
  }
}
