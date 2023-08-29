import 'package:flutter/material.dart';
import 'package:flutter_favourite_places/models/place.dart';
import 'package:flutter_favourite_places/providers/place_provider.dart';
import 'package:flutter_favourite_places/widgets/input_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlace extends ConsumerWidget {
  AddPlace({super.key});

  final _formKey = GlobalKey<FormState>();
  String _enteredName = "";

  void _resetData() {
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void addPlace() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref.read(placeProvider.notifier).addPlace(
              Place(name: _enteredName),
            );
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              decoration: const InputDecoration(
                label: Text("Name", style: TextStyle(fontSize: 18)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 2) {
                  return "Name should be between 2 to 50 character";
                }
                return null;
              },
              onSaved: (newValue) {
                _enteredName = newValue!;
              },
            ),
            const SizedBox(height: 12),
            const InputImage(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _resetData,
                  child: const Text("Reset"),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: addPlace,
                  label: const Text("Add Place"),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
