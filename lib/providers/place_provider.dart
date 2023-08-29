import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_favourite_places/models/place.dart';

class PlaceProvider extends StateNotifier<List<Place>> {
  // We initialize the list of places to an empty list
  PlaceProvider() : super([]);

  void addPlace(Place places) {
    state = [...state, places];
  }
}

final placeProvider = StateNotifierProvider<PlaceProvider, List<Place>>((ref) {
  return PlaceProvider();
});
