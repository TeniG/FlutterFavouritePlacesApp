# flutter_favourite_places

This demo Flutter project is an application for managing a list of favorite places and making use of **device native features**. It consists of two main screens: a "Place List" screen and an "Add New Place" screen. The "Add New Place" screen allows users to input a title, **capture an image using the device's camera or select one from their device's gallery**, and obtain the **current location using the device's GPS**. There are also "Add New Place" and "Reset" buttons for saving the place and clearing the input fields.

In addition to leveraging device-native features, the project also incorporates a **local database using SqfLite**. This database is utilized to efficiently store and retrieve data related to favorite places, enhancing the overall management of saved locations.

Key components and features used in this project include:

**Dart:**
- The Dart programming language is used for the Flutter app development.

**Widgets:**
- Various Flutter widgets like Stack, ListView, CircleAvatar, FileImage, Positioned, NetworkImage, GestureDetector, and GoogleMap are employed to create the user interface.

**Device Native Features:**
- **Camera**: The project utilizes the device's camera to capture images for new place entries.
- **Location Services**: The application uses the device's GPS capabilities to obtain the current location when adding a new place.
- **Storage**: To save and manage images and data locally, the project accesses the device's storage and file system.

**Google API:**
- Google's Geocoding API is used to convert latitude and longitude coordinates into human-readable addresses.
- Maps API is utilized to obtain snapshots of specific places on the map.

**Flutter Packages:**
- **ImagePicker**: Used to capture or select images from the device's camera or gallery.
- **Location**: To retrieve the current device location.
- **Geocoding**: Helps get the current location information.
- **GeoLocator**: To fetch the address from latitude and longitude.
- **Google_Maps_flutter**: Used for selecting and displaying location on a map.
- **Path_Provider**: Provides access to the system path.
- **Path**: Used for constructing platform-specific paths.
- **SqfLite**: To create and manage a local database for storing and retrieving data.
- **Http**: Used for making HTTP requests.

In summary, this Flutter project demonstrates the implementation of a favorite place management application with features for adding new places, capturing images using the device's camera, obtaining the device's current location, and utilizing various Flutter packages and Google APIs for enhanced functionality, all while making the most of device native features."

## Here is a quick demo of the app:

This demo video is recorded in an emulator so by default the location is displayed as Google Office. In the actual device exact location is displayed.




https://github.com/TeniG/FlutterFavouritePlacesApp/assets/43024245/ab4f35fb-4f2b-43e0-93eb-f700aafde635




