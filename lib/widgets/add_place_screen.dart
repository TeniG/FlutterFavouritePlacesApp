import 'package:flutter/material.dart';
import 'package:flutter_favourite_places/models/places.dart';

class AddPlace extends StatelessWidget {
   AddPlace({super.key});

  final _formKey = GlobalKey<FormState>();

  final String _enteredName = "";

  void _resetData() {
    _formKey.currentState?.reset();
  }

  void _savePlace() {
    if (!_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        Places(_enteredName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Place"),
      ),
      body: Form(
        child: Row(children: [
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
              _enteredName:
              newValue;
            },
          ),
          Column(
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
    );
  }
}
