import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

import 'package:flutter_favourite_places/models/place.dart';

const datebaseName = "places.db";
const userPlacesTable = "user_places";

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, datebaseName),
      onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE $userPlacesTable(id TEXT PRIMARY KEY, name TEXT, image_path TEXT, lat REAL, lng REAL, address TEXT)");
  }, version: 1);

  return db;
}

class PlaceNotifier extends StateNotifier<List<Place>> {
  // We initialize the list of places to an empty list
  PlaceNotifier() : super([]);

  Future<void> getAllPlaces() async {
    final db = await _getDatabase();
    final placesData = await db.query(userPlacesTable);

    final places = placesData
        .map(
          (row) => Place(
            id: row['id'] as String,
            name: row['name'] as String,
            image: File(row['image_path'] as String),
            placeLocation: PlaceLocation(
                latitude: row['lat'] as double,
                longitude: row['lng'] as double,
                address: row['address'] as String),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(Place places) async {
    final db = await _getDatabase();
    db.insert(userPlacesTable, {
      "id": places.id,
      "name": places.name,
      "image_path": places.image.path,
      "lat": places.placeLocation.latitude,
      "lng": places.placeLocation.longitude,
      "address": places.placeLocation.address
    });

    state = [
      places,
      ...state,
    ];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Place>>((ref) {
  return PlaceNotifier();
});
