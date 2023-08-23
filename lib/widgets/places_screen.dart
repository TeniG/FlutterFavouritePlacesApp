import 'package:flutter/material.dart';
import 'package:flutter_favourite_places/widgets/add_place_screen.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() {
    return PlacesScreenState();
  }
}

class PlacesScreenState extends State<PlacesScreen> {
  void _addPlace() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const AddPlace();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Text("Place list"),
    );
  }
}
