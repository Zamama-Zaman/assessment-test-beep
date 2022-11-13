import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather/weather.dart';

class HomeController extends GetxController {
  late GoogleMapController _googleMapController;

  late CameraPosition _cameraPosition;

  late Position _getCurrentPosition;

  RxList<Marker> marker = <Marker>[].obs;

  GoogleMapController get googleMapController => _googleMapController;

  CameraPosition get cameraPosition => _cameraPosition;

  Position get getCurrentPosition => _getCurrentPosition;

  RxInt temp = 40.obs;

  RxString cityName = "Riyadh".obs;

  setGoogleMapController(GoogleMapController controller) {
    _googleMapController = controller;
  }

  //* Setting up first Camera Postion with variable
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  //* Setting up first Camera Postion with funcation
  setCameraPosition() {
    _cameraPosition = const CameraPosition(
      target: LatLng(37.773972, -122.431297),
      zoom: 11.5,
    );
  }

  //* Store current temperature in Celcius in (temp) variable
  Future<void> currentWeather() async {
    WeatherFactory wf = WeatherFactory(
      "856822fd8e22db5e1ba48c0e7d69844a",
      language: Language.ENGLISH,
    );
    Weather w = await wf.currentWeatherByLocation(
      _getCurrentPosition.latitude,
      _getCurrentPosition.longitude,
    );
    temp.value = w.temperature!.celsius!.toInt();
  }

  //* Assiging pin location city in (cityName) variable
  Future<void> getCityName() async {
    var address = await Geocoder.local.findAddressesFromCoordinates(
      Coordinates(_getCurrentPosition.latitude, _getCurrentPosition.longitude),
    );
    cityName = address[0].locality.obs;
  }

  //* Asking permission to user and assiging pin location in (_getCurrentPosition) variable
  Future<void> getUserCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    } else {
      _getCurrentPosition = await Geolocator.getCurrentPosition();
    }
  }

  //* Setting up the Marker of initial location
  Future<void> setFirstMarker() async {
    marker.add(
      const Marker(
        markerId: MarkerId('1'),
        position: LatLng(37.773972, -122.431297),
        infoWindow: InfoWindow(
          title: "My current location",
        ),
      ),
    );
  }

  //* Setting up the Marker of current Location
  Future<void> setMarker() async {
    marker.add(
      Marker(
        markerId: const MarkerId('2'),
        position:
            LatLng(_getCurrentPosition.latitude, _getCurrentPosition.longitude),
        infoWindow: const InfoWindow(
          title: "My current location",
        ),
      ),
    );
  }

  //* Setting up camera position at current location
  Future<void> setCurrrentCameraPosition() async {
    _cameraPosition = CameraPosition(
      zoom: 14,
      target:
          LatLng(_getCurrentPosition.latitude, _getCurrentPosition.longitude),
    );
    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
