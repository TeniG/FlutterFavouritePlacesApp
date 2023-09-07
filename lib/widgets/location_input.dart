
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  bool isGettingLocation = false;

  Future<bool> _handleLocationPermission() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void _getCurrentLocation() async {
    final hasLocationPermission = await _handleLocationPermission();
    if (!hasLocationPermission) {
      return;
    }
  
    setState(() {
      isGettingLocation = true;
    });

    LocationData locationData = await  Location().getLocation();

    setState(() {
      isGettingLocation = false;
    });

    var latitude = locationData.latitude;
    var longitude = locationData.longitude;
    print("latitude: $latitude, longitude: $longitude");
    
  }


  @override
  Widget build(BuildContext context) {
    Widget previewLocationcontent = Text(
      "No Location Choosen yet..",
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (isGettingLocation) {
      previewLocationcontent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              ),
            ),
            child: previewLocationcontent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Get Current Location"),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text("Select your location on Map"),
            )
          ],
        )
      ],
    );
  }
}
