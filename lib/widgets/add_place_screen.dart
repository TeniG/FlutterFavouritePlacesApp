import 'package:flutter/material.dart';
import 'package:flutter_favourite_places/models/places.dart';
import 'package:flutter_favourite_places/providers/place_provider.dart';
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
    void _savePlace() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref.watch(placeProvider.notifier).addPlace(Places(_enteredName));
         Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(label: Text("Name")),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _resetData,
                  child: const Text("Reset"),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _savePlace,
                  child: const Text("Save Place"),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
