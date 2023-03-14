import 'dart:io';

class Location {
  final double lattitude;
  final double longitude;
  final String address;

  Location(
      {required this.lattitude,
      required this.longitude,
      required this.address});
}

class Place {
  final String id;
  final String title;
  final Location location;
  final File image;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});
}
