import 'package:flutter/material.dart';
import 'package:flutter_favourite_places/models/place.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddress;
  Position? _currentPosition;
  bool _isGettingLocation = false;
  PlaceLocation? _placeLocation;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true;
  }

  void showProgress() {
    setState(() {
      _isGettingLocation = true;
    });
  }

  void hideProgress() {
    setState(() {
      _isGettingLocation = false;
    });
  }

  Future<Position?> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      return value;
    }).catchError((onError) {
      debugPrint(onError);
    });
  }

  Future<String?> _getAddressFromLatLng(
      double latitude, double longitude) async {
    debugPrint("latitude: $latitude, longitude:$longitude");
    return await placemarkFromCoordinates(latitude, longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      String address =
          '${place.subLocality}, ${place.thoroughfare},${place.locality} - ${place.postalCode}';
      debugPrint("_currentAddress: $address");

      return address;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void _getUserCurrentLocation() async {
    showProgress();

    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      hideProgress();
      return;
    }

    _currentPosition = await _getCurrentPosition();
    if (_currentPosition == null) {
      hideProgress();
      return;
    }

    String? address = await _getAddressFromLatLng(
        _currentPosition!.latitude, _currentPosition!.longitude);
    if (address == null) {
      hideProgress();
      return;
    }

    setState(() {
      _currentAddress = address;
    });
    
    _placeLocation = PlaceLocation(
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
        address: _currentAddress!);

    hideProgress();
  }

  @override
  Widget build(BuildContext context) {
    Widget previewLocationcontent = Text(
      (_currentAddress) != null
          ? _currentAddress!
          : "No Location Choosen yet..",
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_isGettingLocation) {
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
              onPressed: _getUserCurrentLocation,
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
