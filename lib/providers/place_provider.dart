import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_favourite_places/models/places.dart';

class PlaceProvider extends StateNotifier<List<Places>> {
  // We initialize the list of places to an empty list
  PlaceProvider() : super([]);

  void addPlace(Places places) {
    state = [...state, places];
  }
}

final placeProvider = StateNotifierProvider<PlaceProvider, List<Places>>((ref) {
  return PlaceProvider();
});
