import 'package:flutter/material.dart';
import 'package:flutter_favourite_places/models/place.dart';
import 'package:flutter_favourite_places/providers/place_provider.dart';
import 'package:flutter_favourite_places/screens/add_place_screen.dart';
import 'package:flutter_favourite_places/screens/place_details_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlaceListScreenState();
  }
}

class _PlaceListScreenState extends ConsumerState<PlaceListScreen> {
  void _addPlace() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AddPlace();
      }),
    );
  }

  void launchPlaceDetailsScreen(Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) {
        return PlaceDetailsScreen(
          place: place,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final placeList = ref.watch(placeProvider);

    Widget content =  Center(
      child: Text(
        "No Places added yet",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );

    if (placeList.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (ctx, position) {
          return ListTile(
            title: Text(
              placeList[position].name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            onTap: () {
              return launchPlaceDetailsScreen(placeList[position]);
            },
          );
        },
        itemCount: placeList.length,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: _addPlace,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
