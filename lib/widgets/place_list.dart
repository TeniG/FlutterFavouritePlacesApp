import 'package:flutter/material.dart';

import 'package:flutter_favourite_places/models/place.dart';
import 'package:flutter_favourite_places/screens/place_details_screen.dart';

class PlaceList extends StatelessWidget {
  PlaceList({super.key, required this.placeList});

  final List<Place> placeList;

  void launchPlaceDetailsScreen(Place place) {}
  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        "No Places added yet",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );

    if (placeList.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (ctx, position) {
          return ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(placeList[position].image),
            ),
            title: Text(
              placeList[position].name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(placeList[position].placeLocation.address,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) {
                  return PlaceDetailsScreen(
                    place: placeList[position],
                  );
                }),
              );
            },
          );
        },
        itemCount: placeList.length,
      );
    }

    return content;
  }
}
