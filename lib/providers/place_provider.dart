import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_favourite_places/models/place.dart';

class PlaceNotifier extends StateNotifier<List<Place>> {
  // We initialize the list of places to an empty list
  PlaceNotifier() : super([]);

  void addPlace(Place places) {
    state = [...state, places];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Place>>((ref) {
  return PlaceNotifier();
});
