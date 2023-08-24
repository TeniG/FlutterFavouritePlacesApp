import 'package:flutter/material.dart';
import 'package:flutter_favourite_places/providers/place_provider.dart';
import 'package:flutter_favourite_places/widgets/add_place_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  void _addPlace() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AddPlace();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final placeList = ref.watch(placeProvider);

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
      body: ListView.builder(
        itemBuilder: (ctx, position) {
          return ListTile(
            title: Text(placeList[position].name),
          );
        },
        itemCount: placeList.length,
      ),
    );
  }
}
