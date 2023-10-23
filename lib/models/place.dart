import 'dart:io';

import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class Place {
  Place({
    String? id,
    required this.name,
    required this.image,
    required this.placeLocation,
  }) : id = id ?? uuid.v4();
  final String id;
  final String name;
  final File image;
  final PlaceLocation placeLocation;
}
