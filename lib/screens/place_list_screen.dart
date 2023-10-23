import 'package:flutter/material.dart';
import 'package:flutter_favourite_places/models/place.dart';
import 'package:flutter_favourite_places/providers/place_provider.dart';
import 'package:flutter_favourite_places/screens/add_place_screen.dart';
import 'package:flutter_favourite_places/screens/place_details_screen.dart';
import 'package:flutter_favourite_places/widgets/location_page.dart';
import 'package:flutter_favourite_places/widgets/place_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlaceListScreenState();
  }
}

class _PlaceListScreenState extends ConsumerState<PlaceListScreen> {
  late Future<void> _placeFuture;

  @override
  void initState() {
    super.initState();
    _placeFuture = ref.read(placeProvider.notifier).getAllPlaces();
  }

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
      body: FutureBuilder(
        future: _placeFuture,
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(child: CircularProgressIndicator())
              : PlaceList(placeList: placeList);
        },
      ),
    );
  }
}
